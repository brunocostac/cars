//
//  CarDetailPresenter.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarDetailPresenter: AnyObject {
    func interactor(didRetrieveCar car: Car)
    func interactor(didFailRetrieveCar error: Error)
}

class CarDetailPresenterImplementation: CarDetailPresenter {
    
    var viewController: CarDetailPresenterOutput?
    
    func interactor(didRetrieveCar car: Car) {
        let carString = car.name
        viewController?.presenter(didRetrieveItem: carString ?? "")
    }
    
    func interactor(didFailRetrieveCar error: Error) {
        viewController?.presenter(didFailRetrieveItem: error.localizedDescription)
    }
}
