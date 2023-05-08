//
//  CategorizedCarListPresenter.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import Foundation

protocol CategorizedCarListPresenter: AnyObject {
    func interactor(didRetrieveCars cars: [Car])
    func interactor(didFailRetrieveCars error: Error)
    func interactor(didFindCar car: Car, category: Category)
}

class CategorizedCarListPresenterImplementation: CategorizedCarListPresenter {
    weak var viewController: CategorizedCarListPresenterOutput?
    
    func interactor(didRetrieveCars cars: [Car]) {
        viewController?.presenter(didRetrieveCars: cars)
    }
    
    func interactor(didFailRetrieveCars error: Error) {
        
    }
    
    func interactor(didFindCar car: Car, category: Category) {
        viewController?.presenter(didObtainCarId: car.id, category: category)
    }
}
