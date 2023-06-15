//
//  CategorizedCarListViewController.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import UIKit
import SkeletonView

protocol CategorizedCarListPresenterOutput: AnyObject {
    func presenter(didRetrieveCars cars: [Car])
    func presenter(didObtainCarId id: Int, category: Category)
}

protocol CategorizedCarListViewControllerDelegate: AnyObject {
    func didNavigateToDetailsScreen()
}

class CategorizedCarListViewController: UIViewController {
    var selectedCategory: Category?
    var categorizedCarsView: CategorizedCarListView?
    var interactor: CategorizedCarListInteractor?
    var router: CategorizedCarListRouter?
    private var cars: [Car] = []
    
    weak var delegate: CategorizedCarListViewControllerDelegate?
    
    override func loadView() {
        view = categorizedCarsView
        title = self.selectedCategory?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.showAnimatedGradientInView()
        self.interactor?.selectedCategory = self.selectedCategory
        self.interactor?.viewDidLoad()
    }
    
    func showAnimatedGradientInView() {
        view.isSkeletonable = true
        DispatchQueue.main.async {
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func setupTableView() {
        self.categorizedCarsView?.tableView.delegate = self
        self.categorizedCarsView?.tableView.dataSource = self
        self.categorizedCarsView?.tableView.register(CategorizedCarTableViewCell.self, forCellReuseIdentifier: "CategorizedCarTableViewCell")
        self.categorizedCarsView?.tableView.separatorStyle = .none
    }
}

extension CategorizedCarListViewController: CategorizedCarListPresenterOutput {
    func presenter(didObtainCarId id: Int, category: Category) {
        self.router?.navigationController = self.navigationController
        self.router?.routeToDetail(with: id, category: category)
        self.delegate?.didNavigateToDetailsScreen()
    }
    
    func presenter(didRetrieveCars cars: [Car]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view.hideSkeleton()
            self.cars = cars
            self.categorizedCarsView?.tableView.reloadData()
        }
    }
}

extension CategorizedCarListViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CategorizedCarTableViewCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategorizedCarTableViewCell", for: indexPath) as? CategorizedCarTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(title: self.cars[indexPath.row].name.uppercased(), imageURL: self.cars[indexPath.row].url_image, price: self.cars[indexPath.row].price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectRow(at: indexPath.row)
    }
}

