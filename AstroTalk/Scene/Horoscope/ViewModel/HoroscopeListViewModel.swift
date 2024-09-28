//
//  HoroscopeViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//

import Foundation

class HoroscopeListViewModel {
    var onHoroscopesUpdated: (() -> Void)?
    var horoscopeDetail: [HoroscopeDetail] = []
    var horoscopeList: [HoroscopeDetail] = []
    var horoscopes: [Horoscope] = []
    private let horoscopeService = HoroscopeService()
    var coordinator: AppCoordinator?

    func fetchHoroscope() {
        horoscopeService.fetchHoroscope{ [weak self] result in
            switch result {
            case .success(let horoscopes):
                    self?.horoscopes = horoscopes
                self?.onHoroscopesUpdated?()
            case .failure(let error):
                print("Failed to fetch planets: \(error.localizedDescription)")
            }
            
        }
    }
//    func didSelectHoroscope(at indexPath: IndexPath) {
//        let selectedHoroscope = horoscopes[indexPath.row]
//        coordinator?.showHoroscopeList()
//    }

    func horoscope(at index: Int) -> Horoscope {
        return horoscopes[index]
    }


   



//    func horoscopeDetail(at index: Int) -> HoroscopeDetail {
//        return horoscopeDetail(at: index)
//    }
}
