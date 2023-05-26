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
}

class CarDetailViewController: UIViewController {
    // MARK: - Properties
    var carDetailView: CarDetailView?
    var interactor: CarDetailInteractor?
    weak var presenter: CarDetailPresenter?
    var router: CarDetailRouter?
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        self.view = carDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimatedGradientSkeleton()
        self.interactor?.viewDidLoad()
        self.createFavoriteButton()
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
        let favButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favButtonTapped))
        navigationItem.rightBarButtonItem = favButton
    }
    
    @objc func favButtonTapped() {
        
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
    func presenter(didRetrieveCar car: Car) {
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
