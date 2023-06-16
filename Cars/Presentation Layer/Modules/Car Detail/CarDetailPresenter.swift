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
    func interactor(didRetrieveCarStatus isFavorite: Bool)
}

class CarDetailPresenterImplementation: CarDetailPresenter {
    var viewController: CarDetailPresenterOutput?
    
    func interactor(didRetrieveCar car: Car) {
        viewController?.presenter(didRetrieveCar: car)
    }
    
    func interactor(didFailRetrieveCar error: Error) {
        viewController?.presenter(didFailRetrieveItem: error.localizedDescription)
    }
    
    func interactor(didRetrieveCarStatus isFavorite: Bool) {
        viewController?.presenter(didRetrieveCarStatus: isFavorite)
    }
}
