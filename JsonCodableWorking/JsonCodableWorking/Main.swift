//
//  Main.swift
//  JsonCodableWorking
//
//  Created by Koray Urun on 30.01.2026.
//

import SwiftUI

// Basic JSON DECODING

// JSON STRUCTURE
let json = """
    {
    "flightNumber": "TK001",
    "origin": "IST",
    "destination": "JFK",
    "price": 299.99
    }
    """

// Swift Model
struct Flightt: Codable, Identifiable {
    let id = UUID()
    let flightNumber: String
    let origin: String
    let destination: String
    let price: Double
}


// Decode
let jsonData = json.data(using: .utf8)!
let decoder = JSONDecoder()
let flight = try! decoder.decode(Flightt.self, from: jsonData)
//print(flight.flightNumber) // "TK001"


// 2. ARRAY OF OBJECTS
let jsonArray = """
    [
    {"code": "IST", "name": "Istanbul"},
    {"code": "JFK", "name": "New York"},
    {"code": "LHR", "name": "London"}
    ]
    """

struct Airport: Codable {
    let code: String
    let name: String
}

let data = jsonArray.data(using: .utf8)!
let airports = try! decoder.decode([Airport].self, from: data)
// print(airports.count)


// 3. NESTED JSON
let complexJSON = """
    {
    "flight" : {
        "number" : "TK001",
        "airline" : {
            "name" : "Turkish Airlines",
            "code" : "TK"
                    }
                },
     "price" : 299.99
    }
    """

struct FlightData : Codable {
    let flight: FlightInfo
    let price : Double
}

struct FlightInfo : Codable {
    let number : String
    let airline : Airline
}

struct Airline : Codable {
    let name : String
    let code : String
}

let flightData = try! decoder.decode(FlightData.self, from :complexJSON.data(using: .utf8)!)
// print(flightData.flight.airline.name) // "Turkish Airlines"


// 4. CUSTOM KEYS
// JSON uses snake_case, Swift uses camelCase
let snakeJSON = """
    {
        "flight_number" : "TK001",
        "departure_time" : "10:30",
        "arrival_time" : "14:45"
    }
    """

struct Flight2 : Codable {
    let flightNumber : String
    let departureTime : String
    let arrivalTime : String
    
    enum CodingKeys : String, CodingKey {
        case flightNumber = "flight_number"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
    }
    
}

let flight2 = try! decoder.decode(Flight2.self, from: snakeJSON.data(using: .utf8)!)



// URLSession & Async/Await

// 1.BASIC URL REQUEST

// Old Way (completion handler)

func fetchFligthsOld(completion: @escaping ([Flightt]) -> Void) {
    let url = URL(string : "https://api.example.com/flights")!
    
    URLSession.shared.dataTask(with: url) {data , response, error in
        guard let data = data else {return}
        
        if let flight = try? JSONDecoder().decode([Flightt].self, from: data) {
            DispatchQueue.main.async {
                completion(flight)
            }
        }
        
        
    }.resume()
}

// NEW way (async/await)

func fetchFlights() async throws -> [Flightt] {
    let url = URL(string: "https://api.example.com/flights")!
    
    let (data,response) = try await URLSession.shared.data(from : url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    
    let flights = try JSONDecoder().decode([Flightt].self, from: data)
    return flights
    
}


// Error enum

enum NetworkError : LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    
    var errorDescription : String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid HTTP response"
        case .decodingError:
            return "Error decoding JSON"
        }
    }
}




// 2. USE IN VIEWMODEL
@MainActor
class FlightViewModel : ObservableObject {
    @Published var flights : [Flightt] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadFlights() async {
        isLoading = true
        errorMessage = nil
        
        do {
            flights = try await fetchFlights()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
        
    }
}

// 3. USE IN VIEW (with .task)
struct FlightListView : View {
    @StateObject private var viewModel = FlightViewModel()
    
    var body : some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            }
            else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
            } else {
                List(viewModel.flights) { flight in
                    Text(flight.flightNumber)
                }
            }
        }
        .task { // Automatically handle async
            await viewModel.loadFlights()
        }
    }
    
    
    
    
}




















