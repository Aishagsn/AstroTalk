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
        let nib = UINib(nibName: "HoroscopeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HoroscopeCell")
    }
    
    private func bindViewModel() {
        viewModel.onHoroscopesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension HoroscopeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.horoscopes.count
        print(viewModel.horoscopes.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoroscopeCell", for: indexPath) as! HoroscopeTableViewCell
        let horoscope = viewModel.horoscopes[indexPath.row]
        cell.configure(with: horoscope)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        guard let selectedHoroscopeDetail = viewModel.horoscopeDetail(at: indexPath.row) else {
        //            print("Failed to get horoscope detail at index \(indexPath.row)")
        //            return
        //        }
        //
        //        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "HoroscopeDetailViewController") as? HoroscopeDetailViewController else {
        //            print("Could not instantiate HoroscopeDetailViewController")
        //            return
        //        }
        //
        //
        //        detailVC.viewModel = HoroscopeDetailViewModel(horoscopeDetail: selectedHoroscopeDetail)
        //
        //        navigationController?.pushViewController(detailVC, animated: true)
        //    }
        //
        if let selectedHoroscopeDetail = viewModel.horoscopeDetail(at: indexPath.row) {
                   if let detailVC = storyboard?.instantiateViewController(withIdentifier: "HoroscopeDetailViewController") as? HoroscopeDetailViewController {
                       detailVC.viewModel = HoroscopeDetailViewModel(horoscopeDetail: selectedHoroscopeDetail)
                       navigationController?.pushViewController(detailVC, animated: true)
                   } else {
                       print("Could not instantiate HoroscopeDetailViewController")
                   }
               } else {
                   print("Error: HoroscopeDetail is nil")
               }
           }
       }
