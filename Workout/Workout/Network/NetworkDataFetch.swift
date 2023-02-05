//
//  NetworkDataFetch.swift
//  Workout
//
//  Created by Сергей Анпилогов on 04.02.2023.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    
    func fetchWeather(responce: @escaping (Welcome, Error?) -> Void) {
        
        NetworkRequest.shared.requestData { result in
            
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(Welcome.self, from: data)
                    responce(weather, nil)
                } catch let jasonError {
                    print("failed to decode JSON", jasonError)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
