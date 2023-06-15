//
//  FavoritesListViewController.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import UIKit


protocol FavoritesListPresenterOutput: AnyObject {
    func presenter(didRetrieveCars cars: [Car])
}

class FavoritesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesView: FavoritesListView?
    var interactor: FavoritesListInteractor?
    var router: FavoritesListRouter?
    var cars: [Car] = []
    
    override func loadView() {
        self.title = "Garage"
        self.view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor?.viewDidAppear()
    }
    
    func setupTableView() {
        self.favoritesView?.tableView.delegate = self
        self.favoritesView?.tableView.dataSource = self
        self.favoritesView?.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
        self.favoritesView?.tableView.rowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(title: cars[indexPath.row].name, imageURL: cars[indexPath.row].url_image, price: cars[indexPath.row].price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.interactor?.didPressRemoveFavorite(indexPath: indexPath)
        }
    }
}

extension FavoritesListViewController: FavoritesListPresenterOutput {
    func presenter(didRetrieveCars cars: [Car]) {
        self.cars = cars
        DispatchQueue.main.async {
            self.favoritesView?.tableView.reloadData()
        }
    }
}
