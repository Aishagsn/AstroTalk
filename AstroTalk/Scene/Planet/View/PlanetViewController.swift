////
////  PlanetViewController.swift
////  AstroTalk
////
////  Created by Aisha on 24.08.24.
////
//
//import UIKit
//
//class PlanetViewController: UIViewController {
//    @IBOutlet weak var tableView: UITableView!
//    var viewModel: PlanetViewModel
//    
//    init(/*tableView: UITableView!,*/ viewModel: PlanetViewModel) {
////        self.tableView = tableView
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        bindViewModel()
//        viewModel.fetchPlanets()
//    }
//    
//    private func setupUI() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    private func bindViewModel() {
//        viewModel.planets.bind { [weak self] _ in
//            guard let self = self else { return }
//            self.tableView.reloadData()
//        }
//    }
//
//}
//
//extension PlanetViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.planets.value.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
//        let planet = viewModel.planets.value[indexPath.row]
//        cell.textLabel?.text = planet.name
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.didSelectPlanet(at: indexPath)
//    }
//}
