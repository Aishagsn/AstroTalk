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
    func horoscopeDetail(at index: Int) -> HoroscopeDetail? {
        guard index >= 0 && index < horoscopeDetail.count else {
            print("Index \(index) is out of range. Available range: 0 to \(horoscopeDetail.count - 1).")
            return nil
        }
        
        let detail = horoscopeDetail[index]
        return HoroscopeDetail(
            features: detail.features ?? "Features not available",
            planet: detail.planet ?? "Planet not available",
            type: detail.type ?? "Type not available"
        )
    }

   



//    func horoscopeDetail(at index: Int) -> HoroscopeDetail {
//        return horoscopeDetail(at: index)
//    }
}
