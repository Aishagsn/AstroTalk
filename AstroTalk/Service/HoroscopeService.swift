//
//  HoroscopeService.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation
class HoroscopeService {
    func fetchHoroscope(for sign: String, period: String, completion: @escaping (Horoscope) -> Void) {
        let urlString = "http://fakeapi.com/horoscope/\(period)?sign=\(sign)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let horoscope = try decoder.decode(Horoscope.self, from: data)
                    completion(horoscope)
                } catch {
                    print("Failed to decode JSON")
                }
            }
        }.resume()
    }
}
