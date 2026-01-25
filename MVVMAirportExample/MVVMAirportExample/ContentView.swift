//
//  ContentView.swift
//  MVVMAirportExample
//
//  Created by Koray Urun on 25.01.2026.
//

import SwiftUI

// Model
struct Airport : Identifiable, Codable {
    let id : UUID
    let code : String
    let name : String
    let city : String
}

// Service (data layer)
class AirportService {
    func fetchAirports() -> [Airport] {
        // in real app, this would be API call
        return [Airport(id: UUID(), code: "IST", name: "Istanbul Airport", city: "Istanbul"),
                Airport(id: UUID(), code: "JFK", name: "JFK International", city: "New York"),
                Airport(id: UUID(), code: "LHR", name:  "Heathrow", city:  "London")]
    }
}
    
    
// VIEWMODEL
class AirportListViewModel: ObservableObject {
    @Published var airports: [Airport] = []
    @Published var searchText = ""
    @Published var isLoading = false
    
    private let service = AirportService()
    
    var filteredAirports: [Airport] {
        if searchText.isEmpty {
            return airports
        } else {
            return airports.filter { airport in
                airport.code.lowercased().contains(searchText.lowercased()) ||
                airport.city.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func loadAirports() {
        isLoading = true
        
        // Simulate delay
        DispatchQueue.main.asyncAfter(deadline: . now() + 0.5) {
            self.airports = self.service.fetchAirports()
            self.isLoading = false
        }
    }
}
    
// VIEW
struct AirportListView : View {
    @StateObject private var viewModel = AirportListViewModel()
    
    var body: some View {
        NavigationStack{
            Group{
                if viewModel.isLoading {
                    ProgressView()
                } else{
                    List(viewModel.filteredAirports){ airport in
                        AirportRow(airport:airport)
                    }
                }
            }
            .navigationTitle(Text("Airports"))
            .searchable(text: $viewModel.searchText, prompt: "Search Airports")
            .onAppear(){
                viewModel.loadAirports()
            }
        }
    }
}
    
    
struct AirportRow: View {
        
    let airport: Airport
        
    var body: some View {
        HStack {
            Text(airport.code)
                .font(.headline)
                .frame(width: 50, alignment: .leading)
            
        VStack(alignment: .leading) {
            Text(airport.name)
                .font(.subheadline)
            Text(airport.city)
                .font(.caption)
                .foregroundColor(.gray)
                }
            }
        }
    }
    
    

#Preview {
    AirportListView()
}
