//
//  MatchesListViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation

class MatchesListViewModel {
    private let matchService: MatchService = .init()
    var matches: [Match] = []

    func fetchMatches(completion: @escaping () -> Void) {
        matchService.fetchMatches { [weak self] result in
            switch result {
            case .success(let matches):
                self?.matches = matches
            case .failure(let error):
                print("Failed to fetch matches: \(error)")
            }
            completion()
        }
    }

    func getMatch(at index: Int) -> Match? {
        return matches.indices.contains(index) ? matches[index] : nil
    }
}

   
