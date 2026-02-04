import Foundation

struct Airport: Identifiable, Codable {
    let id: String
    let code: String
    let name: String
    let city: String
    let country: String
}

struct Flight: Identifiable, Codable {
    let id: String
    let flightNumber: String
    let origin: String
    let destination: String
    let price: Double
    let departureTime: Date
    let arrivalTime: Date
    let duration: Int // dakika cinsinden
    let airline: String
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


// 2. CREATE MOCK SERVICE
actor MockDataService {
    static let shared = MockDataService()
    
    func loadAirports() async throws -> [Airport] {
        // simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        guard let url = Bundle.main.url(forResource: "airports", withExtension: "json"),
              let data = try? Data(contentsOf : url) else {
            throw NetworkError.invalidURL
        }
        
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        return airports
    }
    
    func searchFlights(from origin: String, to destination: String) async throws -> [Flight] {
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        guard let url = Bundle.main.url(forResource: "flights", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NetworkError.invalidURL
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let allFlights = try decoder.decode([Flight].self, from: data)
        
        // Filter by route
        let filtered = allFlights.filter {$0.origin == origin && $0.destination == destination
        }
        return filtered

    }

}

// 3. PROTOCOL FOR EASY SWITCHING
protocol FlightServiceProtocol {
    func searchFlights(from: String, to: String) async throws -> [Flight]
}

class MockFlightService : FlightServiceProtocol {
    func searchFlights(from: String, to: String) async throws -> [Flight] {
        return try await MockDataService.shared.searchFlights(from: from, to: to)
    }
}

class RealFlightService : FlightServiceProtocol {
    func searchFlights(from: String, to: String) async throws -> [Flight] {
        // Real API call here
        let url = URL(string : "https://api.example.com/flights? from=\(from)&to=\(to)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Flight].self, from: data)
    }
}

// Use in ViewModel
class FlightViewModel: ObservableObject {
    private let service: FlightServiceProtocol
    
    init(service : FlightServiceProtocol = MockFlightService()){
        self.service = service // easy to switch
    }
    
    func search(from: String, to: String) async {
        do{
            flights = try await service.searchFlights(from: from, to: to)
        }catch {
            errorMessage = error.localizedDescription
        }
    }
    
    
}
