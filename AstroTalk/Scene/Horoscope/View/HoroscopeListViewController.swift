//
//  HoroscopeViewController.swift
//  AstroTalk
//
//  Created by Aisha on 28.08.24.
//
import UIKit

class HoroscopeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = HoroscopeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchHoroscope()
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
}

extension HoroscopeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.horoscope.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let horoscope = viewModel.horoscope(at: indexPath.row)
        cell.textLabel?.text = viewModel.horoscope[indexPath.row].horoscopeName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHoroscopeDetail = viewModel.horoscopeDetail(at:indexPath.row)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "HoroscopeDetailViewController") as! HoroscopeDetailViewController
        detailVC.viewModel = HoroscopeDetailViewModel(horoscopeDetail: selectedHoroscopeDetail)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

