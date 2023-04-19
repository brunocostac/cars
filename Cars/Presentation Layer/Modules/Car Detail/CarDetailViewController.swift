//
//  CarListViewController.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

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
        self.interactor?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Presenter Output
extension CarDetailViewController: CarDetailPresenterOutput {
    func presenter(didRetrieveCar car: Car) {
        carDetailView?.updateLabel(with: car.name)
        carDetailView?.updateImage(imageURL: car.image_url)
    }
    
    func presenter(didFailRetrieveItem message: String) {
        showError(with: message)
    }
}
