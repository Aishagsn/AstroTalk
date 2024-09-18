import Foundation

class HoroscopeService {
    
    func fetchHoroscope(completion: @escaping (Result<[Horoscope], Error>) -> Void) {
        NetworkManager.request(model: [Horoscope].self,
                               endpoint: "api/horoscope",
                               method: .get) { horoscopes, error in
            if let error = error {
                completion(.failure(NetworkErrorHoroscope.customError(error)))
            } else if let horoscopes = horoscopes {
                completion(.success(horoscopes))
            } else {
                completion(.failure(NetworkErrorHoroscope.noData))
            }
        }
    }
}

enum NetworkErrorHoroscope: Error {
    case noData
    case customError(String)
}
