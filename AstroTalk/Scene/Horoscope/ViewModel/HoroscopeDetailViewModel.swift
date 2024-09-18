//
//  HoroscopeDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation

class HoroscopeDetailViewModel {
    private let horoscopeDetail: HoroscopeDetail
    
    init(horoscopeDetail: HoroscopeDetail) {
        self.horoscopeDetail = horoscopeDetail
    }
  
    var features: String {
        return horoscopeDetail.features ?? "Features not available"
    }
    
    var type: String {
        return horoscopeDetail.type ?? "Type not available"
    }
    
    var planet: String {
        return horoscopeDetail.planet ?? "Planet not available"
    }
}


