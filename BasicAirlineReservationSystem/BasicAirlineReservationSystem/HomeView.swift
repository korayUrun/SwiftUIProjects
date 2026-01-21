//
//  ContentView.swift
//  BasicAirlineReservationSystem
//
//  Created by Koray Urun on 21.01.2026.
//

import SwiftUI

struct Airport : Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let city: String
}

struct Flight: Identifiable {
    let id = UUID()
    let airline: String
    let departureTime: String
    let arrivalTime: String
    let price: String
}

struct HomeView: View {
    
    var airports: [Airport] = [Airport(code: "IST", name: "Istanbul Airport", city: "Istanbul"),
    Airport(code: "JFK", name: "JFK Airport", city: "New York"),Airport(code: "ANT", name: "Antalya Airport", city: "Antalya")]
    
    // Secimleri tutacak degiskenler
    @State private var fromAirport: Airport?
    @State private var toAirport: Airport?
    @State private var flightDate = Date() // yeni tarih değişkeni
    
    // Sayfalarin acilip kapanmasini kontrol edenler
    @State private var showFromSelection = false
    @State private var showToSelection = false
    
    var body: some View {
            NavigationStack {
                ZStack {
                    // Arka Plan
                    Color.blue.opacity(0.4).ignoresSafeArea()
                    
                    // ANA VSTACK (Tüm elemanları kapsar)
                    VStack(spacing: 20) {
                        
                        // --- 1. ÜST KISIM (Butonlar) ---
                        HStack {
                            // FROM BUTTON
                            Button(action: { showFromSelection = true }) {
                                VStack {
                                    Text("From:")
                                        .foregroundStyle(.black)
                                    Text(fromAirport?.code ?? "Select")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                }
                            }
                            .sheet(isPresented: $showFromSelection) {
                                AirportSelectionView(airports: airports, selectedAirport: $fromAirport)
                            }
                            
                            Spacer()
                            
                            // Uçak İkonu
                            Image(systemName: "airplane")
                                .font(.largeTitle)
                                .foregroundStyle(.blue.opacity(0.4))
                            
                            Spacer()
                            
                            // TO BUTTON
                            Button(action: { showToSelection = true }) {
                                VStack {
                                    Text("To:")
                                        .foregroundStyle(.black)
                                    Text(toAirport?.code ?? "Select")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                }
                            }
                            .sheet(isPresented: $showToSelection) {
                                AirportSelectionView(airports: airports, selectedAirport: $toAirport)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .foregroundStyle(.green.opacity(0.7))
                        
                        // --- 2. ORTA KISIM (Tarih) ---
                        VStack {
                            Text("Departure Date")
                                .font(.headline)
                            
                            DatePicker("Choose Date", selection: $flightDate, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding()
                        }
                        
                        Spacer() // Bu, butonu en alta iter
                        
                        
                        // --- 3. ALT KISIM (Search Butonu) ---
                        // DÜZELTME: Artık VStack'in içinde!
                        NavigationLink {
                            FlightListView()
                        } label: {
                            HStack{
                                Text("Search Flights")
                                Image(systemName: "magnifyingglass")
                                
                            }
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(fromAirport != nil && toAirport != nil ? Color.blue : Color.gray)
                            .foregroundStyle(.white)
                            .cornerRadius(12)}
                        .disabled(fromAirport == nil || toAirport == nil)
                        .padding(.horizontal) // Kenarlardan taşmasın diye
                        .padding(.bottom, 20) // En alttan biraz yukarıda kalsın
                        
                    } // ANA VSTACK BURADA BİTİYOR
                    
                }
                .navigationTitle("Flight Booking")
            }
        }
}

struct AirportSelectionView : View {
    let airports: [Airport] // listeyi buraya alacağız
    @Binding var selectedAirport: Airport? // Seçimi ana sayfaya haber vereceğiz
    @Environment(\.dismiss) var dismiss // sayfayı kapatmak için
    var body: some View {
        List(airports){airport in
            Button{
                selectedAirport = airport // 1. seçimi yap
                dismiss() // 2. sayfayı kapat
            } label: {
                HStack{
                    Text(airport.code)
                        .fontWeight(.bold)
                    Text(airport.name)
                }
                .foregroundStyle(.black)
            }
        }
        
    }
}


// Screen 3: FlightListView (Şimdilik boş, hata vermesin diye)
struct FlightListView: View {
    let flights : [Flight] = [Flight(airline: "Turkish Airlines", departureTime: "10:00", arrivalTime: "11:30", price: "2.500 ₺"),
                              Flight(airline: "Pegasus", departureTime: "14:00", arrivalTime: "15:30", price: "1.800 ₺"),
                              Flight(airline: "AnadoluJet", departureTime: "18:30", arrivalTime: "20:00", price: "2.100 ₺")
                          ]
    var body: some View {
        
        List(flights){flight in
            NavigationLink{
                FlightDetailView(flight:flight) // detay ekranına git
            }label:{
                // Flight Card Design
                HStack{
                    Image(systemName: "airplane.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
                    VStack(alignment : .leading){
                        Text(flight.airline)
                            .font(.headline)
                        
                        Text("\(flight.departureTime) -> \(flight.arrivalTime)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer() // fiyatı saga ittik
                    
                    Text(flight.price)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.green)
                }
                .padding(.vertical,8)

            }
            .listRowBackground(Color.white.opacity(0.8))
        }
        .scrollContentBackground(.hidden)
        .appBackground()
        .navigationTitle("Available Flights")
    }
}

struct FlightDetailView: View {
    let flight: Flight
    
    var body: some View {
        VStack(spacing: 20) {
            Text(flight.airline)
                .font(.largeTitle)
                .bold()
            
            Text("\(flight.departureTime) - \(flight.arrivalTime)")
                .font(.title2)
            
            Text(flight.price)
                .font(.title)
                .foregroundStyle(.green)
            
            Button("Book Now") {
                // Aksiyon sonra eklenecek
            }
            .buttonStyle(.borderedProminent)
        }
        .appBackground()
        .navigationTitle("Flight Details")
    }
}

#Preview { HomeView() }

extension View {
    func appBackground() -> some View {
        ZStack {
            // 1. Senin istediğin arka plan rengi
            Color.blue.opacity(0.4).ignoresSafeArea()
            
            // 2. 'self' burada, bu fonksiyonu çağıran View'dır (List, Text vs.)
            self
        }
    }
}

