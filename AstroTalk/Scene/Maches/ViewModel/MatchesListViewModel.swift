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

//    init(matchService: MatchService) {
//        self.matchService = matchService
//    }

//    func fetchMatches(completion: @escaping () -> Void) {
//        matchService.fetchMatches { [weak self] matches in
//            self?.matches = matches ?? <#default value#>
//            completion()
//        }
//    }
//
//    func getMatch(at index: Int) -> Match? {
//        return matches.indices.contains(index) ? matches[index] : nil
//    }
//}
    func fetchMatches(completion: @escaping () -> Void) {
           matchService.fetchMatches { [weak self] matches, error in
               if let matches = matches {
                   self?.matches = matches
               } else if let error = error {
                   print("Failed to fetch matches: \(error)")
               }
               completion()
           }
       }

       func getMatch(at index: Int) -> Match? {
           return matches.indices.contains(index) ? matches[index] : nil
       }
   }
