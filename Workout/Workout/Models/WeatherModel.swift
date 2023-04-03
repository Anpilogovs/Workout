import Foundation
import UIKit

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    
    var temperatureCelsius: String {
        return String(format: "%.1f", temp - 273.15)
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
    
    var iconLocal: String {
        switch id {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "cloud.fog"
        case 800: return "sun.max"
        case 801...804: return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var informationAboutWeather: String {
        switch iconLocal {
        case "cloud.bolt": return "On the streets of a cloudy"
        case "cloud.drizzle": return "It is raining outside"
        case "cloud rain": return "Inappropriate weather for training"
        case "cloud.snow": return "Better to work at home"
        case "cloud.fog": return "Be careful on the street of the fog"
        case "sun.max": return "Excellent weather for training"
        case "cloud.bolt": return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
