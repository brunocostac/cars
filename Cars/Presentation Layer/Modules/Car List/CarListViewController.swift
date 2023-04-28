//
//  ViewController.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

protocol CarListPresenterOutput: AnyObject {
    func presenter(didRetrieveCars cars: [Car])
    func presenter(didRetrieverCarTypeList carTypeList: [[String: Any]])
    func presenter(didRetrieveCarTypeName name: String)
    func presenter(didFailRetrieveCars message: String)
    func presenter(didObtainCarId id: Int, carType: CarType)
    func presenter(didFailObtainCarId message: String)
}

class CarListViewController: UIViewController {
    
    // MARK: - Properties
    var carsView: CarListView?
    var interactor: CarListInteractor?
    var router: CarListRouter?
    var carsRetrieved = false
    private var cars: [Car] = []
    private var carTypeList: [[String : Any]] = []
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = carsView
        carsView?.carCollectionView.delegate = self
        carsView?.carCollectionView.dataSource = self
        carsView?.carCollectionView.register(UINib(nibName: "CarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarCollectionViewCell")
        
        carsView?.carTypeListCollectionView.delegate = self
        carsView?.carTypeListCollectionView.dataSource = self
        carsView?.carTypeListCollectionView.register(UINib(nibName: "CarTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarTypeCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.interactor?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Home"
    }
}

// MARK: - Presenter Output
extension CarListViewController: CarListPresenterOutput {
    func presenter(didRetrieverCarTypeList carTypeList: [[String : Any]]) {
        self.carTypeList = carTypeList
        self.carsView?.reloadTypeListCarCollectionView()
    }
    
    func presenter(didRetrieveCars cars: [Car]) {
        self.carsRetrieved = true
        self.cars = cars
        self.carsView?.reloadCarCollectionView()
    }
    
    func presenter(didRetrieveCarTypeName name: String) {
        DispatchQueue.main.async {
          self.carsView?.titleLabel.text = name
        }
    }
    
    func presenter(didFailRetrieveCars message: String) {
        self.showError(with: message)
        self.carsView?.reloadCarCollectionView()
    }
    
    func presenter(didObtainCarId id: Int, carType: CarType) {
        self.router?.routeToDetail(with: id, carType: carType)
    }
    
    func presenter(didFailObtainCarId message: String) {
        self.showError(with: message)
    }
}

// MARK: - UITableView DataSource & Delegate
extension CarListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return carTypeList.count
        } else {
            if cars.count == 0 && carsRetrieved {
                carsView?.carCollectionView.setEmptyView(title: "No cars were found.", message: "", messageImage: UIImage(systemName: "magnifyingglass.circle")!)
            } else {
                carsView?.carCollectionView.backgroundView = nil
            }
            return cars.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            guard let carTypeCell = self.carsView?.carTypeListCollectionView.dequeueReusableCell(withReuseIdentifier: "CarTypeCollectionViewCell", for: indexPath) as? CarTypeCollectionViewCell else {
                return UICollectionViewCell()
            }
            carTypeCell.updateImage(imageURL: self.carTypeList[indexPath.row]["image_url"] as! String)
            carTypeCell.titleLabel.text = self.carTypeList[indexPath.row]["name"] as? String
            
            return carTypeCell
            
        } else {
            guard let carCell = self.carsView?.carCollectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell", for: indexPath) as? CarCollectionViewCell else {
                return UICollectionViewCell()
            }
            carCell.updateImage(imageURL: self.cars[indexPath.row].url_image)
            carCell.nameLabel.text = self.cars[indexPath.row].name
            carCell.descLabel.text = "$ \(self.cars[indexPath.row].price)"
            return carCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView.tag == 1 {
            let itemWidth = collectionView.bounds.width / 3
            let itemHeight = itemWidth * 0.8
            return CGSize(width: itemWidth, height: itemHeight)
        } else {
            let minimumInteritemSpacing = 9
            let optimisedWidth = (Int(collectionView.frame.width) - minimumInteritemSpacing) / 2
            return CGSize(width: optimisedWidth , height: optimisedWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            self.interactor?.didSelectCarType(at: indexPath.row)
        } else {
            self.interactor?.didSelectRow(at: indexPath.row)
        }
    }
}
