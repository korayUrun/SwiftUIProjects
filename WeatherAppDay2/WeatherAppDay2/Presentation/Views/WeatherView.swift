//
//  WeatherView.swift
//  WheaterAppDay2
//
//  Created by Koray Urun on 7.03.2026.
//

import SwiftUI

struct WeatherView : View {
    
    @StateObject private var viewModel = WeatherViewModel(
        repository: MockWeatherRepository())
    
    
      var body: some View {
          NavigationStack {
              VStack(spacing: 0) {
                  
                  // Şehir seçici
                  Picker("Şehir", selection: $viewModel.selectedCity) {
                      ForEach(viewModel.cities, id: \.self) { city in
                          Text(city).tag(city)
                      }
                  }
                  .pickerStyle(.segmented)
                  .padding()
                  .onChange(of: viewModel.selectedCity) {
                      viewModel.onCityChanged()
                  }
                  
                  // State'e göre içerik
                  Group {
                      switch viewModel.state {
                      case .idle:
                          Color.clear
                          
                      case .loading:
                          VStack(spacing: 16) {
                              ProgressView()
                                  .scaleEffect(1.5)
                              Text("Hava durumu yükleniyor...")
                                  .foregroundStyle(.secondary)
                          }
                          .frame(maxWidth: .infinity, maxHeight: .infinity)
                          
                      case .success(let weather):
                          WeatherCard(weather: weather)
                          
                      case .failure(let message):
                          VStack(spacing: 20) {
                              Image(systemName: "wifi.slash")
                                  .font(.system(size: 52))
                                  .foregroundStyle(.red)
                              Text(message)
                                  .multilineTextAlignment(.center)
                                  .foregroundStyle(.secondary)
                              Button("Tekrar Dene") {
                                  viewModel.onRetry()
                              }
                              .buttonStyle(.borderedProminent)
                          }
                          .padding(32)
                          .frame(maxWidth: .infinity, maxHeight: .infinity)
                      }
                  }
                  .animation(.easeInOut(duration: 0.3), value: viewModel.selectedCity)
              }
              .navigationTitle("Hava Durumu")
              .toolbar {
                  ToolbarItem(placement: .topBarTrailing) {
                      Toggle("Hata Modu", isOn: $viewModel.shouldFail)
                          .toggleStyle(.button)
                          .tint(.red)
                  }
              }
              .onAppear { viewModel.onAppear() }
              .onDisappear { viewModel.onDisappear() }
          }
      }
  }

  // MARK: — WeatherCard
  struct WeatherCard: View {
      let weather: WeatherInfo
      
      var body: some View {
          VStack(spacing: 24) {
              
              // Ana bilgi
              VStack(spacing: 8) {
                  Image(systemName: weather.icon)
                      .font(.system(size: 72))
                      .foregroundStyle(.orange)
                  
                  Text("\(Int(weather.temperature))°C")
                      .font(.system(size: 64, weight: .thin))
                  
                  Text(weather.condition)
                      .font(.title3)
                      .foregroundStyle(.secondary)
                  
                  Text(weather.city)
                      .font(.headline)
              }
              .padding(.top, 32)
              
              Divider()
              
              // Detaylar
              HStack(spacing: 0) {
                  DetailItem(icon: "humidity.fill",
                             value: "%\(weather.humidity)",
                             label: "Nem")
                  
                  Divider().frame(height: 40)
                  
                  DetailItem(icon: "wind",
                             value: "\(Int(weather.windSpeed)) km/s",
                             label: "Rüzgar")
              }
              .padding(.horizontal)
              
              Spacer()
          }
      }
  }

  // MARK: — DetailItem
  struct DetailItem: View {
      let icon: String
      let value: String
      let label: String
      
      var body: some View {
          VStack(spacing: 6) {
              Image(systemName: icon)
                  .font(.title2)
                  .foregroundStyle(.blue)
              Text(value)
                  .font(.headline)
              Text(label)
                  .font(.caption)
                  .foregroundStyle(.secondary)
          }
          .frame(maxWidth: .infinity)
      }
  }

