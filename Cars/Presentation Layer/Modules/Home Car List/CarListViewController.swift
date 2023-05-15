//
//  ViewController.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

protocol CarListPresenterOutput: AnyObject {
    func presenter(didRetrieveCars cars: [Car])
    func presenter(didRetrieveCategories categories: [[String: Any]])
    func presenter(didRetrieveCategoryName name: String)
    func presenter(didFailRetrieveCars message: String)
    func presenter(didObtainCarId id: Int, category: Category)
    func presenter(didFailObtainCarId message: String)
    func presenter(didSelectCategory category: Category)
}

class CarListViewController: UIViewController {
    
    // MARK: - Properties
    var carsView: CarListView?
    var interactor: CarListInteractor?
    var router: CarListRouter?
    var carsRetrieved = false
    private var cars: [Car] = []
    private var categories: [[String : Any]] = []
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeCollectionViews()
        self.interactor?.initializeData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.cars = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = "Home"
        self.interactor?.reloadData()
    }
    
    func initializeCollectionViews() {
        self.view = carsView
        self.carsView?.carCollectionView.delegate = self
        self.carsView?.carCollectionView.dataSource = self
        self.carsView?.carCollectionView.register(UINib(nibName: "HomeCarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCarCollectionViewCell")
        
        self.carsView?.categoryCollectionView.delegate = self
        self.carsView?.categoryCollectionView.dataSource = self
        self.carsView?.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
}

// MARK: - Presenter Output
extension CarListViewController: CarListPresenterOutput {
    func presenter(didSelectCategory category: Category) {
        self.router?.routeToCategorizedCarList(category: category)
    }
    
    func presenter(didRetrieveCategories categories: [[String : Any]]) {
        self.categories = categories
        self.carsView?.reloadCategoriesCollectionView()
    }
    
    func presenter(didRetrieveCars cars: [Car]) {
        self.carsRetrieved = true
        self.cars = cars
        self.carsView?.reloadCarCollectionView()
    }
    
    func presenter(didRetrieveCategoryName name: String) {
        DispatchQueue.main.async {
          self.carsView?.titleLabel.text = name
        }
    }
    
    func presenter(didFailRetrieveCars message: String) {
        self.showError(with: message)
        self.carsView?.reloadCarCollectionView()
    }
    
    func presenter(didObtainCarId id: Int, category: Category) {
        self.router?.routeToDetail(with: id, category: category)
    }
    
    func presenter(didFailObtainCarId message: String) {
        self.showError(with: message)
    }
}

// MARK: - UITableView DataSource & Delegate
extension CarListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return categories.count
        } else {
            if self.cars.count == 0 && carsRetrieved {
                self.carsView?.carCollectionView.setEmptyView(title: "No cars were found.", message: "", messageImage: UIImage(systemName: "magnifyingglass.circle")!)
            } else {
                self.carsView?.carCollectionView.backgroundView = nil
            }
            return self.cars.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            guard let categoryCell = self.carsView?.categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            categoryCell.updateImage(imageURL: self.categories[indexPath.row]["image_url"] as! String)
            categoryCell.titleLabel.text = self.categories[indexPath.row]["name"] as? String
            
            return categoryCell
            
        } else {
            guard let carCell = self.carsView?.carCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCarCollectionViewCell", for: indexPath) as? HomeCarCollectionViewCell else {
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
            let minimumInteritemSpacing = 5
            let optimisedWidth = (Int(collectionView.frame.size.width - 20) - minimumInteritemSpacing) / 2
            return CGSize(width: optimisedWidth , height: optimisedWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            self.interactor?.didSelectCategory(at: indexPath.row)
        } else {
            self.interactor?.didSelectRow(at: indexPath.row)
        }
    }
}
