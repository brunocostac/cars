//
//  CarListViewController.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit
import SkeletonView

protocol CarDetailPresenterOutput: AnyObject {
    func presenter(didRetrieveCar car: Car)
    func presenter(didFailRetrieveItem message: String)
    func presenter(didRetrieveCarStatus isFavorite: Bool)
}

class CarDetailViewController: UIViewController {
    
    // MARK: - Properties
    var carDetailView: CarDetailView?
    var interactor: CarDetailInteractor?
    weak var presenter: CarDetailPresenter?
    var router: CarDetailRouter?
    
    var car: Car?
    var isFavorite: Bool = false
    
    var favButton: UIBarButtonItem?
    

    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        self.view = carDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createFavoriteButton()
        self.showAnimatedGradientSkeleton()
    }
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)
        self.interactor?.viewDidAppear()
    }
    
    func showAnimatedGradientSkeleton() {
        DispatchQueue.main.async {
            self.carDetailView?.imageView.showAnimatedGradientSkeleton()
            self.carDetailView?.titleLabel.showAnimatedGradientSkeleton()
            self.carDetailView?.descLabel.showAnimatedGradientSkeleton()
            self.carDetailView?.locationTitleLabel.showAnimatedGradientSkeleton()
            self.carDetailView?.mapView.showAnimatedGradientSkeleton()
        }
    }
    
    func createFavoriteButton() {
        self.favButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favButtonTapped))
        navigationItem.rightBarButtonItem = favButton
    }
    
    @objc func favButtonTapped() {
        self.interactor?.didPressFavoriteButton(car: self.car!)
    }
    
    func updateTitle(with title: String) {
        DispatchQueue.main.async {
           self.title = title
        }
    }
    
    func hideAnimatedGradientSkeleton() {
        self.carDetailView?.imageView.hideSkeleton()
        self.carDetailView?.mapView.hideSkeleton()
        self.carDetailView?.titleLabel.hideSkeleton()
        self.carDetailView?.locationTitleLabel.hideSkeleton()
        self.carDetailView?.descLabel.hideSkeleton()
    }
}

// MARK: - Presenter Output
extension CarDetailViewController: CarDetailPresenterOutput {
    func presenter(didRetrieveCarStatus isFavorite: Bool) {
        if isFavorite {
            DispatchQueue.main.async {
                self.favButton?.image = UIImage(systemName: "heart.fill")
            }
        } else {
            DispatchQueue.main.async {
                self.favButton?.image = UIImage(systemName: "heart")
            }
        }
    }
    
    func presenter(didRetrieveCar car: Car) {
        self.car = car
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hideAnimatedGradientSkeleton()
            self.updateTitle(with: car.name)
            self.carDetailView?.updateLabels(with: car.name, desc: car.desc)
            self.carDetailView?.updateImage(imageURL: car.url_image)
            self.carDetailView?.updateMapRegionAndAnnotation(car: car)
        }
    }
    
    func presenter(didFailRetrieveItem message: String) {
        showError(with: message)
    }
}
