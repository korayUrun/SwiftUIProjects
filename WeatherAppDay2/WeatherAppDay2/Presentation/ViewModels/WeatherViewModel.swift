import Foundation
import Combine   // ← bunu ekle, tüm hatalar gider

@MainActor
final class WeatherViewModel: ObservableObject {
    
    // MARK: — Output
    @Published var state: ViewState<WeatherInfo> = .idle
    @Published var shouldFail = false {
        didSet { repository.shouldFail = shouldFail }
    }
    
    // MARK: — Private
    private let repository: MockWeatherRepository
    private var loadTask: Task<Void, Never>?
    
    let cities = ["Istanbul", "Ankara", "Antalya", "Izmir"]
    @Published var selectedCity = "Istanbul"
    
    init(repository: MockWeatherRepository) {
        self.repository = repository
    }
    
    // MARK: — Input
    func onAppear() {
        loadTask?.cancel()
        loadTask = Task { await fetchWeather() }
    }
    
    func onRetry() {
        loadTask?.cancel()
        loadTask = Task { await fetchWeather() }
    }
    
    func onCityChanged() {
        loadTask?.cancel()
        loadTask = Task { await fetchWeather() }
    }
    
    func onDisappear() {
        loadTask?.cancel()
        loadTask = nil
    }
    
    // MARK: — Private
    private func fetchWeather() async {
        state = .loading
        do {
            let weather = try await repository.fetchWeather(for: selectedCity)
            state = .success(weather)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
