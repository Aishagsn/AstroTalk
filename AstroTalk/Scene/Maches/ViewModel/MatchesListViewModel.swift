//
//  MatchesListViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import Foundation

class MatchesListViewModel {
    private let matchService: MatchService
    var matches: [Match] = []

    init(matchService: MatchService) {
        self.matchService = matchService
    }

    func fetchMatches(completion: @escaping () -> Void) {
        matchService.fetchMatches { [weak self] matches in
            self?.matches = matches
            completion()
        }
    }

    func getMatch(at index: Int) -> Match? {
        return matches.indices.contains(index) ? matches[index] : nil
    }
}
