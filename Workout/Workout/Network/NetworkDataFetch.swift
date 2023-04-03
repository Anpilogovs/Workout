import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchWeather(responce: @escaping (WeatherModel, Error?) -> Void) {
        
        NetworkRequest.shared.requestData { result in
            
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
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
