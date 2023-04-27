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
    var carsRetrieved = false
    private var cars: [Car] = []
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = carsView
        self.carsView?.delegate = self
        carsView?.collectionView.delegate = self
        carsView?.collectionView.dataSource = self
        carsView?.collectionView.register(UINib(nibName: "CarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.interactor?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Home"
    }
    
    func didSegmentedValueChanged(selectedSegmentIndex: Int) {
        self.interactor?.didSelectCarType(at: selectedSegmentIndex)
    }
}

// MARK: - Presenter Output
extension CarListViewController: CarListPresenterOutput {
 
    func presenter(didRetrieveCars cars: [Car]) {
        self.carsRetrieved = true
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
extension CarListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cars.count == 0 && carsRetrieved {
            carsView?.collectionView.setEmptyView(title: "No cars were found.", message: "", messageImage: UIImage(systemName: "magnifyingglass.circle")!)
        } else {
            carsView?.collectionView.backgroundView = nil
        }
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.carsView?.collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell", for: indexPath) as? CarCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.updateImage(imageURL: self.cars[indexPath.row].url_image)
        cell.nameLabel.text = self.cars[indexPath.row].name
        cell.descLabel.text = "$ \(self.cars[indexPath.row].price)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumInteritemSpacing = 9
        let optimisedWidth = (Int(collectionView.frame.width) - minimumInteritemSpacing) / 2
        return CGSize(width: optimisedWidth , height: optimisedWidth)
    }
}
