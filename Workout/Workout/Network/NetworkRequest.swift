//
//  NetworkRequest.swift
//  Workout
//
//  Created by Сергей Анпилогов on 04.02.2023.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    private init() {}
    
    func requestData(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let key = "3bef07ccea8211abf63ae8583581acdd"
        let latitude = 48.3794
        let longitude = 31.1656

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)"

        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
