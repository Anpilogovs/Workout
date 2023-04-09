import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    private init() {}
    
    func requestData(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let key = "3bef07ccea8211abf63ae8583581acdd"
        let latitude =  50.4501
        let longitude = 30.5234
        let date = DateComponents(calendar: .current, year: 2023, month: 4, day: 9).date!
        let timestamp = Int(date.timeIntervalSince1970)

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&dt=\(timestamp)&appid=\(key)"

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
