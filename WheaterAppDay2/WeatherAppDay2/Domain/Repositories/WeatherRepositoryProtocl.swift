//
//  WeatherRepositoryProtocl.swift
//  WheaterAppDay2
//
//  Created by Koray Urun on 7.03.2026.
//

protocol WeatherRepositoryProtocol {
    func fetchWeather(for city: String) async throws -> WeatherInfo
}
