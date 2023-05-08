//
//  CategorizedCarListViewController.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import UIKit


protocol CategorizedCarListPresenterOutput: AnyObject {
    func presenter(didRetrieveCars cars: [Car])
    func presenter(didObtainCarId id: Int, category: Category)
}

class CategorizedCarListViewController: UIViewController {
    var selectedCategory: Category?
    var categorizedCarsView: CategorizedCarListView?
    var interactor: CategorizedCarListInteractor?
    var router: CategorizedCarListRouter?
    private var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        view = categorizedCarsView
        self.categorizedCarsView?.tableView.dataSource = self
        self.categorizedCarsView?.tableView.delegate = self
        self.categorizedCarsView?.tableView.register(CategorizedCarTableViewCell.self, forCellReuseIdentifier: "CategorizedCarTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor?.selectedCategory = self.selectedCategory
        self.interactor?.viewDidAppear()
    }
}

extension CategorizedCarListViewController: CategorizedCarListPresenterOutput {
    func presenter(didObtainCarId id: Int, category: Category) {
        self.router?.navigationController = self.navigationController
        self.router?.routeToDetail(with: id, category: category)
    }
    
    func presenter(didRetrieveCars cars: [Car]) {
        self.cars = cars
        DispatchQueue.main.async {
            self.categorizedCarsView?.tableView.reloadData()
        }
    }
}

extension CategorizedCarListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategorizedCarTableViewCell", for: indexPath) as? CategorizedCarTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: cars[indexPath.row].name, imageURL: cars[indexPath.row].url_image, price: cars[indexPath.row].price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectRow(at: indexPath.row)
    }
}
