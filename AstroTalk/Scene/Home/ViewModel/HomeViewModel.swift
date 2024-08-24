//
//  HomeViewModel.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import Foundation

class HomeViewModel {
    
    var stories: [Story] = []
    var posts: [Post] = []
    var motivationMessages: [MotivationMessage] = []
    
    var onStoriesFetched: (() -> Void)?
    var onPostsFetched: (() -> Void)?
    var onMotivationMessagesFetched: (() -> Void)?
    
   private var coordinator: AppCoordinator?
    
    init(coordinator: AppCoordinator? = nil) {
          self.coordinator = coordinator
      }
    
    func fetchData() {
        // Mock API request to fetch stories, posts, and motivation messages data
        let mockAPIURL = "https://yourmockapi.com/api/data"
        fetchMockData(from: mockAPIURL) { [weak self] data in
            // Process the data and update the stories, posts, and motivation messages
            // self?.stories = fetchedStories
            // self?.posts = fetchedPosts
            // self?.motivationMessages = fetchedMotivationMessages
            self?.onStoriesFetched?()
            self?.onPostsFetched?()
            self?.onMotivationMessagesFetched?()
        }
    }
    
    private func fetchMockData(from url: String, completion: @escaping (Data?) -> Void) {
        // Implement mock API request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Simulate a network response delay
            // Call completion with mock data
            completion(nil) // Replace with actual mock data
        }
    }
}
