//
//  HomeViewController.swift
//  AstroTalk
//
//  Created by Aisha on 02.08.24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var motivationCollectionView: UICollectionView!
    
     var viewModel = HomeViewModel()
    var userList = [User]()
    var filterUser = [User]()
    var motivationMessages: [MotivationMessage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        viewModel.fetchData()
    }
    
    private func configureUI() {
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryCell")
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        
        motivationCollectionView.delegate = self
        motivationCollectionView.dataSource = self
        motivationCollectionView.register(UINib(nibName: "MotivationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MotivationCell")
    }
    
    private func bindViewModel() {
        viewModel.onStoriesFetched = { [weak self] in
            self?.storiesCollectionView.reloadData()
        }
        viewModel.onPostsFetched = { [weak self] in
            self?.postsTableView.reloadData()
        }
        viewModel.onMotivationMessagesFetched = { [weak self] in
            self?.motivationCollectionView.reloadData()
        }
    }
//    func fetchMotivationData() {
//           NetworkManager.request(model: [MotivationMessage].self, endpoint: "api/motivationMessages") { [weak self] data, error in
//               if let data = data {
//                   self?.motivationMessages = data
//                       self?.motivationCollectionView.reloadData()
//                   
//               } else if let error = error {
//                   print("Error fetching motivation data: \(error)")
//               }
//           }
//       }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storiesCollectionView {
            return viewModel.stories.count
        } else if collectionView == motivationCollectionView {
            return viewModel.motivationMessages.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCollectionViewCell
            let story = viewModel.stories[indexPath.item]
            cell.configure(with: story)
            return cell
        } else if collectionView == motivationCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MotivationCell", for: indexPath) as! MotivationCollectionViewCell
            let motivationMessage = viewModel.motivationMessages[indexPath.item]
            cell.configure(with: motivationMessage)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 100, height: 100)
      }
  }

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterUser = self.userList.filter { user in
            if let firstName = user.firstName {
                return firstName.lowercased().contains(searchText.lowercased()) || searchText.isEmpty
            } else {
                return searchText.isEmpty
            }
        }
        self.storiesCollectionView.reloadData()
        self.motivationCollectionView.reloadData()
        self.postsTableView.reloadData()
    }
}
