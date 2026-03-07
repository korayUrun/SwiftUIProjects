//
//  MockWhetherRepository.swift
//  WheaterAppDay2
//
//  Created by Koray Urun on 7.03.2026.
//

import Foundation

final class MockWhetherRepository: WeatherRepositoryProtocol {
    
    var shouldFail = false
    
    private let mockData: [String: WeatherInfo]
    
}
