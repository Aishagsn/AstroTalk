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
    var horoscopeDetail: [HoroscopeDetail] = []
    var horoscopes: Observable<[Horoscope]> = Observable([])
    private let horoscopeService = HoroscopeService()
    var coordinator: AppCoordinator?

//    func fetchHoroscope(for sign: String, period: String, completion: @escaping () -> Void) {
//        let endpoint = "/api/horoscope"
//
//        NetworkManager.request(model: [Horoscope].self, endpoint: endpoint) { [weak self] data, error in
//            if let data = data {
//                self?.horoscope = data
//                self?.onHoroscopesUpdated?()
//            } else if let error = error {
//                print("Failed to fetch horoscope: \(error)")
//            }
//            completion()
//        }
//    }
    func fetchHoroscope() {
        horoscopeService.fetchHoroscope{ [weak self] result in
            switch result {
            case .success(let horoscopes):
                DispatchQueue.main.async {
                    self?.horoscopes.value = horoscopes
                }
            case .failure(let error):
                print("Failed to fetch planets: \(error.localizedDescription)")
            }
            
        }
    }
    func didSelectPlanet(at indexPath: IndexPath) {
        let selectedPlanet = horoscopes.value[indexPath.row]
        coordinator?.showHoroscopeList()
    }

    func getHoroscopeName(for index: Int) -> String {
        return horoscope[index].horoscopeName
    }

    func getHoroscopeImage(for index: Int) -> String {
        return horoscope[index].image
    }

//    var numberOfHoroscopes: Int {
//        return horoscope.count
//    }

    func horoscope(at index: Int) -> Horoscope {
        return horoscope[index]
    }
    func horoscopeDetail(at index: Int) -> HoroscopeDetail {
        return horoscopeDetail(at: index)
    }
}
