//
//  ViewController.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

protocol CarListPresenterOutput: AnyObject {
    func presenter(didRetrieveCars cars: [Car])
    func presenter(didFailRetrieveCars message: String)
    func presenter(didObtainCarId id: String)
    func presenter(didFailObtainCarId message: String)
}

class CarListViewController: UIViewController {
    // MARK: - Properties
    
    var carsView: CarListView?
    var interactor: CarListInteractor?
    var router: CarListRouter?
    
    private var cars: [Car] = []
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        self.view = carsView
        carsView?.tableView.delegate = self
        carsView?.tableView.dataSource = self
        carsView?.tableView.register(CarTableViewCell.self, forCellReuseIdentifier: "CarTableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Cars"
    }
}

// MARK: - Presenter Output
extension CarListViewController: CarListPresenterOutput {
    func presenter(didRetrieveCars cars: [Car]) {
        self.cars = cars
        self.carsView?.reloadTableView()
    }
    
    func presenter(didFailRetrieveCars message: String) {
        showError(with: message)
    }
    
    func presenter(didObtainCarId id: String) {
        self.router?.routeToDetail(with: id)
    }
    
    func presenter(didFailObtainCarId message: String) {
        showError(with: message)
    }
}

// MARK: - UITableView DataSource & Delegate
extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.cars.isEmpty ?
            self.carsView?.showPlaceholder() :
            self.carsView?.hidePlaceholder()
        
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "CarTableViewCell")!
        cell.textLabel?.text = self.cars[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectRow(at: indexPath.row)
    }
}
