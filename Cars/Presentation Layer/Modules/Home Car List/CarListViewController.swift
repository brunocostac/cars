//
//  ViewController.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit
import SkeletonView

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
    
    override func loadView() {
        self.view = carsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeCollectionViews()
        self.interactor?.initializeData()
        self.carsView?.setupSkeleton()
        self.showAnimatedGradientInView()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.refreshCollectionsWithDelay()
    }
    
    func showAnimatedGradientInView() {
        DispatchQueue.main.async {
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func refreshCollectionsWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.carsView?.categoryCollectionView.stopSkeletonAnimation()
            self.carsView?.categoryCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.carsView?.categoryCollectionView.reloadData()
            
            self.carsView?.carCollectionView.stopSkeletonAnimation()
            self.carsView?.carCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.carsView?.carCollectionView.reloadData()
        }
    }
    
    func initializeCollectionViews() {
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
    }

    func presenter(didRetrieveCars cars: [Car]) {
        self.carsRetrieved = true
        self.cars = cars
       
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

extension CarListViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        if skeletonView.tag == 1 {
            return "CategoryCollectionViewCell"
        } else {
           return "HomeCarCollectionViewCell"
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
