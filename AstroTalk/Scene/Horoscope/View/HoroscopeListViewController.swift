//
//  HoroscopeViewController.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//
import UIKit

class HoroscopeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // Keep using HoroscopeService in the view model initialization
    var viewModel: HoroscopeListViewModel = HoroscopeListViewModel(horoscopeService: HoroscopeService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        fetchHoroscopes() // Call the method to fetch horoscopes
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func bindViewModel() {
        viewModel.onHoroscopesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func fetchHoroscopes() {
        // Example call to fetch horoscope; adjust parameters as needed
        viewModel.fetchHoroscope(for: "Aries", period: "daily") {
            // Handle completion if needed
        }
    }
}

extension HoroscopeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHoroscopes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let horoscope = viewModel.horoscope(at: indexPath.row)
        cell.textLabel?.text = horoscope.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHoroscope = viewModel.horoscope(at: indexPath.row)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "HoroscopeDetailViewController") as! HoroscopeDetailViewController
        detailVC.viewModel = HoroscopeDetailViewModel(horoscope: selectedHoroscope)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

