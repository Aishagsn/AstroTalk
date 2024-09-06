//
//  HoroscopeViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation

class HoroscopeListViewModel {
    var horoscope: [Horoscope] = []
    var onHoroscopesUpdated: (() -> Void)?

    func fetchHoroscope(for sign: String, period: String, completion: @escaping () -> Void) {
        let endpoint = "horoscope/\(sign)/\(period)"  // Adjust the endpoint based on your API structure

        NetworkManager.request(model: [Horoscope].self, endpoint: endpoint) { [weak self] data, error in
            if let data = data {
                self?.horoscope = data
                self?.onHoroscopesUpdated?()
            } else if let error = error {
                print("Failed to fetch horoscope: \(error)")
            }
            completion()
        }
    }

    func getHoroscopeName(for index: Int) -> String {
        return horoscope[index].horoscopeName
    }

    func getHoroscopeImage(for index: Int) -> String {
        return horoscope[index].image
    }

    var numberOfHoroscopes: Int {
        return horoscope.count
    }

    func horoscope(at index: Int) -> Horoscope {
        return horoscope[index]
    }
}
