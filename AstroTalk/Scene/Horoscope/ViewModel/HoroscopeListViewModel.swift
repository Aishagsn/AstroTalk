//
//  HoroscopeViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation

class HoroscopeListViewModel {
    private let horoscopeService: HoroscopeService
    var horoscope: Horoscope?
    
    // Add a property to notify when horoscopes are updated
    var onHoroscopesUpdated: (() -> Void)?

    init(horoscopeService: HoroscopeService) {
        self.horoscopeService = horoscopeService
    }

    func fetchHoroscope(for sign: String, period: String, completion: @escaping () -> Void) {
        horoscopeService.fetchHoroscope(for: sign, period: period) { [weak self] horoscope in
            self?.horoscope = horoscope
            // Notify that horoscopes have been updated
            self?.onHoroscopesUpdated?()
            completion()
        }
    }

    func getHoroscopeText(for period: String) -> String {
        switch period {
        case "daily":
            return horoscope?.daily ?? "No data"
        case "weekly":
            return horoscope?.weekly ?? "No data"
        case "monthly":
            return horoscope?.monthly ?? "No data"
        default:
            return "No data"
        }
    }

    var numberOfHoroscopes: Int {
        return horoscope == nil ? 0 : 1
    }
   
    func horoscope(at index: Int) -> Horoscope {
        return horoscope!
    }
}
