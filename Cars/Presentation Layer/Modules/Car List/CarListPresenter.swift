//
//  CarListPresenter.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarListPresenter: AnyObject {
    func interactor(didFindCar car: Car)
    func interactor(didRetrieveCars cars: [Car])
    func interactor(didFailRetrieveCars error: Error)
}

class CarListPresenterImplementation: CarListPresenter {
    weak var viewController: CarListPresenterOutput?
    
    func interactor(didRetrieveCars cars: [Car]) {
        //let carsStrings = cars.compactMap { $0.name }
        viewController?.presenter(didRetrieveCars: cars)
    }
    
    func interactor(didFailRetrieveCars error: Error) {
        viewController?.presenter(didFailRetrieveCars: error.localizedDescription)
    }
   
    func interactor(didFindCar car: Car) {
        viewController?.presenter(didObtainCarId: car.id)
    }
}
