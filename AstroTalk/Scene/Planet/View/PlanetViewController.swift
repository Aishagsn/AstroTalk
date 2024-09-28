//
//  PlanetViewController.swift
//  AstroTalk
//
//  Created by Aisha on 24.08.24.
//

import UIKit

class PlanetViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = PlanetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchPlanets()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(PlanetTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "PlanetCell")
        

    }
    
    private func bindViewModel() {
            viewModel.onPlanetsUpdated = { [weak self] in
                self?.tableView.reloadData()
            }
        }

}

extension PlanetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as! PlanetTableViewCell
        let planet = viewModel.planets[indexPath.row]
        cell.configure(with: planet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlanet = viewModel.planets[indexPath.row]
        viewModel.coordinator?.showPlanetDetail(for: selectedPlanet)
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "PlanetDetailViewController") as? PlanetDetailViewController {
            detailVC.viewModel = PlanetDetailViewModel(id: viewModel.planets[indexPath.row].id ?? 0)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
