import Foundation

final class MockWeatherRepository: WeatherRepositoryProtocol {
    
    var shouldFail = false
    
    private let mockData: [String: WeatherInfo] = [
        "Istanbul": WeatherInfo(city: "İstanbul", temperature: 18, condition: "Parçalı Bulutlu", humidity: 72, windSpeed: 14, icon: "cloud.sun.fill"),
        "Ankara":   WeatherInfo(city: "Ankara",   temperature: 12, condition: "Güneşli",        humidity: 45, windSpeed: 22, icon: "sun.max.fill"),
        "Antalya":  WeatherInfo(city: "Antalya",  temperature: 26, condition: "Açık",           humidity: 58, windSpeed: 8,  icon: "sun.max.fill"),
        "Izmir":    WeatherInfo(city: "İzmir",    temperature: 22, condition: "Güneşli",        humidity: 55, windSpeed: 11, icon: "sun.max.fill"),
    ]
    
    func fetchWeather(for city: String) async throws -> WeatherInfo {
        // Sahte ağ gecikmesi
        try await Task.sleep(for: .seconds(1.5))
        
        // Hata modu açıksa fırlat
        if shouldFail {
            throw NSError(
                domain: "WeatherError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Sunucuya ulaşılamıyor. Bağlantını kontrol et."]
            )
        }
        
        // Şehir bulunamazsa varsayılan döndür
        return mockData[city] ?? WeatherInfo(
            city: city,
            temperature: 20,
            condition: "Bilinmiyor",
            humidity: 60,
            windSpeed: 10,
            icon: "questionmark.circle"
        )
    }
}
