
//  Created by Koray Urun on 29.01.2026.

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
struct Flightt: Codable {
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
print(airports.count)


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


