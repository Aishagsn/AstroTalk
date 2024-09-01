//
//  MatchDetailViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation

class MatchDetailViewModel {
    private let matchService: MatchService
    var matchDetail: MatchDetail?
    private var isFollowing: Bool = false

    init(matchService: MatchService) {
        self.matchService = matchService
    }

    func fetchMatchDetail(for name: String, completion: @escaping () -> Void) {
        matchService.fetchMatchDetail(for: name) { [weak self] matchDetail in
            self?.matchDetail = matchDetail
            completion()
        }
    }
    func followUser() {
            // Mevcut durumun tersine çevirilmesi (Takip edildiyse bırak, edilmediyse takip et)
            isFollowing.toggle()
            
            if isFollowing {
                print("\(matchDetail?.name ?? "") takip edildi.")
                // Burada API isteği veya başka bir takip işlemi yapılabilir.
            } else {
                print("\(matchDetail?.name ?? "") takibi bırakıldı.")
                // Burada API isteği veya takibi bırakma işlemi yapılabilir.
            }
        }
}

