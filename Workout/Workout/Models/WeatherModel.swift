//
//  WeatherModel.swift
//  Workout
//
//  Created by Сергей Анпилогов on 04.02.2023.
//

import Foundation
import UIKit

struct Welcome: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    
    var temperatureCelsius: String {
        return String(format: "%.1f", temp)
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







//struct WeatherModel: Decodable {
//    let currentrly: Currently
//}
//
//struct Currently: Decodable {
//    let temperature: Double
//    let icon: String?
//
//
//    var temperatureCelsius: Int  {
//        return (Int(temperature) - 32) * 5 / 9
//    }
//
//    var iconLocal: String {
//        switch icon {
//        case "clear-day": return "clearly"
//        case "clear-night": return "Clear night"
//        case "rain": return "Rain"
//        case "snow": return "Snow"
//        case "sleet": return "Wet snow"
//        case "wind": return "Windy"
//        case "fog": return "For"
//        case "cloudy": return "Cloudy"
//        case "partly-cloudy-day": return "It's a nasty day"
//        case "partly-cloudy-day": return "Сloudy night"
//        default: return "No data"
//        }
//    }
//
//    var description: String {
//        switch icon {
//        case "clear-day": return "clearly"
//        case "clear-night": return "Clear night"
//        case "rain": return "Rain"
//        case "snow": return "Snow"
//        case "sleet": return "Wet snow"
//        case "wind": return "Windy"
//        case "fog": return "For"
//        case "cloudy": return "Cloudy"
//        case "partly-cloudy-day": return "It's a nasty day"
//        case "partly-cloudy-day": return "Сloudy night"
//        default: return "No data"
//        }
//    }
//}
//
