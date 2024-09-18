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
        let storiesEndpoint = "api/stories"
                let postsEndpoint = "api/posts"
                let motivationMessagesEndpoint = "api/motivationMessages"
        
                NetworkManager.request(model: [Story].self, endpoint: storiesEndpoint) { [weak self] (stories, error) in
                    if let stories = stories {
                        self?.stories = stories
                        self?.onStoriesFetched?()
                    } else if let error = error {
                        print("Error fetching stories: \(error)")
                    }
                }
          
                NetworkManager.request(model: [Post].self, endpoint: postsEndpoint) { [weak self] (posts, error) in
                    if let posts = posts {
                        self?.posts = posts
                        self?.onPostsFetched?()
                    } else if let error = error {
                        print("Error fetching posts: \(error)")
                    }
                }
               
                NetworkManager.request(model: [MotivationMessage].self, endpoint: motivationMessagesEndpoint) { [weak self] (messages, error) in
                    if let messages = messages {
                        self?.motivationMessages = messages
                        self?.onMotivationMessagesFetched?()
                    } else if let error = error {
                        print("Error fetching motivation messages: \(error)")
                    }
                }
            }
        }
