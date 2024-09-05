//
//  HoroscopeDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation

class HoroscopeDetailViewModel {
    private let horoscope: Horoscope
    
    init(horoscope: Horoscope) {
        self.horoscope = horoscope
    }
    
    var name: String {
        return horoscope.name
    }
    
    var dateRange: String {
        return horoscope.dateRange
    }
    
    var planet: String {
        return horoscope.planet
    }
    
    var dailyHoroscope: String {
        return horoscope.daily
    }
    
    var weeklyHoroscope: String {
        return horoscope.weekly
    }
    
    var monthlyHoroscope: String {
        return horoscope.monthly
    }
}
