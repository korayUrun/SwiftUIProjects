// TODO: Create models for this JSON:

import Foundation
let json = """
{
    "booking": {
        "reference": "SKY123456",
        "passenger": {
            "name": "John Doe",
            "email": "john@example.com"
        },
        "flight": {
            "number": "TK001",
            "route": {
                "from": "IST",
                "to": "JFK"
            }
        },
        "total_price": 375.00
    }
}
"""

// TODO:  Decode and print booking reference and passenger name


struct BookingData : Codable {
    let booking : Booking
    }

struct Booking : Codable {
    let reference : String
    let passenger : Passenger
    let flight : Flight
    let totalPrice : Double
    
    enum CodingKeys : String , CodingKey {
        case reference, passenger, flight
        case totalPrice = "total_price"
    }
    
}

struct Passenger : Codable {
    let name : String
    let email : String
}

struct Flight : Codable {
    let number : String
    let route : Route
}

struct Route : Codable {
    let from : String
    let to : String
}

do {
    let decoder = JSONDecoder()
    let data = json.data(using: .utf8)

    if let data = data {
        let fetchData = try decoder.decode(BookingData.self, from : data)
        print("Referans: \(fetchData.booking.reference)")
        print("Passenger: \(fetchData.booking.passenger.name)")
    }
    else {
        print("There is an error while decoding")
    }
    
} catch {
    print("Error occured: \(error)")
}


