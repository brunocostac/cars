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
    private var cars: [Car] = []  {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.view.hideSkeleton()
            }
        }
    }
    private var categories: [[String : Any]] = []
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        self.view = carsView
        title = "Cars"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeCollectionViews()
        self.interactor?.initializeData()
        self.showAnimatedGradientInView()
    }
    
    func showAnimatedGradientInView() {
        view.isSkeletonable = true
        [self.carsView?.categoryCollectionView, self.carsView?.carCollectionView].forEach {
            $0?.prepareSkeleton(completion: { done in
                self.view.showAnimatedSkeleton()
            })
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
        DispatchQueue.main.async {
            self.carsView?.categoryCollectionView.reloadData()
        }
    }

    func presenter(didRetrieveCars cars: [Car]) {
        self.carsRetrieved = true
        self.cars = cars
        DispatchQueue.main.async {
            self.carsView?.carCollectionView.reloadData()
        }
    }
    
    func presenter(didRetrieveCategoryName name: String) {
        DispatchQueue.main.async {
          self.carsView?.titleLabel.text = name
        }
    }
    
    func presenter(didFailRetrieveCars message: String) {
        self.showError(with: message)
        self.carsView?.carCollectionView.reloadData()
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
            let categoryCell = self.carsView?.categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            let item = self.categories[indexPath.row]
            
            categoryCell.updateImage(imageURL: item["image_url"] as! String)
            categoryCell.titleLabel.text =  item["name"] as? String

            return categoryCell
            
        } else {
            let carCell = self.carsView?.carCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCarCollectionViewCell", for: indexPath) as! HomeCarCollectionViewCell
            let item = self.cars[indexPath.row]
            
            carCell.updateImage(imageURL: item.url_image)
            carCell.nameLabel.text = item.name
            carCell.descLabel.text = "$ \(item.price)"
            
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
