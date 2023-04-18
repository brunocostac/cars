//
//  CarDetailInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarDetailInteractor: AnyObject {
    var carId: String? { get }
    func viewDidLoad()
}

class CarDetailInteractorImplementation: CarDetailInteractor {
    var carId: String?
    
    var presenter: CarDetailPresenter?
    
    private let carService = CarsServiceImplementation()
    
    func viewDidLoad() {
        do {
            if let car = try carService.getCar(with: self.carId!) {
                presenter?.interactor(didRetrieveCar: car)
            }
        } catch {
            presenter?.interactor(didFailRetrieveCar: error)
        }
    }
}
