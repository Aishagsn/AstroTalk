//
//  MatchesListViewController.swift
//  AstroTalk
//
//  Created by Aisha on 30.08.24.
//

import UIKit

class MatchesListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = MatchesListViewModel()
    var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MatchCell", bundle: nil), forCellWithReuseIdentifier: "MatchCell")
        fetchMatches()
    }

    func fetchMatches() {
        viewModel.fetchMatches { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension MatchesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.matches.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchCell", for: indexPath) as! MatchCell
        
        if let match = viewModel.getMatch(at: indexPath.row) {
            cell.configure(with: match)
        } else {
            // Return an empty cell if the match is nil
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let match = viewModel.getMatch(at: indexPath.row) else { return }
               coordinator?.showMatchDetail(for: match)
           }
    }

