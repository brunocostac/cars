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
    func presenter(didObtainCarId id: Int, carType: CarType)
    func presenter(didFailObtainCarId message: String)
}

class CarListViewController: UIViewController, SegmentedControlDelegate {
    
    // MARK: - Properties
    var carsView: CarListView?
    var interactor: CarListInteractor?
    var router: CarListRouter?
    
    private var cars: [Car] = []
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        self.view = carsView
        self.carsView?.delegate = self
        carsView?.tableView.delegate = self
        carsView?.tableView.dataSource = self
        carsView?.tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarTableViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Cars"
    }
    
    func didSegmentedValueChanged(selectedSegmentIndex: Int) {
        self.interactor?.didSelectCarType(at: selectedSegmentIndex)
    }
}

// MARK: - Presenter Output
extension CarListViewController: CarListPresenterOutput {
 
    func presenter(didRetrieveCars cars: [Car]) {
        self.cars = cars
        self.carsView?.reloadTableView()
    }
    
    func presenter(didFailRetrieveCars message: String) {
        self.showError(with: message)
        self.carsView?.reloadTableView()
    }
    
    func presenter(didObtainCarId id: Int, carType: CarType) {
        self.router?.routeToDetail(with: id, carType: carType)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cars.count == 0 {
            carsView?.tableView.setEmptyView(title: "No cars were found.", message: "", messageImage: UIImage(systemName: "magnifyingglass.circle")!)
        } else {
            carsView?.tableView.backgroundView = nil
        }
        return cars.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as? CarTableViewCell else {
            return UITableViewCell()
        }
        cell.updateImage(imageURL: self.cars[indexPath.row].url_image)
        cell.nameLabel.text = self.cars[indexPath.row].name
        cell.descLabel.text = self.cars[indexPath.row].desc
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectRow(at: indexPath.row)
    }
}
