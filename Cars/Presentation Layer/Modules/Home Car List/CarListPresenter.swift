//
//  CarListPresenter.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarListPresenter: AnyObject {
    func interactor(didFindCar car: Car, category: Category)
    func interactor(didRetrieveCars cars: [Car])
    func interactor(didRetrieveCategoryName name: String)
    func interactor(didRetrieveCategories categories: [[String: Any]])
    func interactor(didFailRetrieveCars error: Error)
    func interactor(didSelectCategory category: Category)
}

class CarListPresenterImplementation: CarListPresenter {
    weak var viewController: CarListPresenterOutput?
    
    func interactor(didRetrieveCategoryName name: String) {
        viewController?.presenter(didRetrieveCategoryName: name)
    }
    
    func interactor(didRetrieveCategories categories: [[String : Any]]) {
        viewController?.presenter(didRetrieveCategories: categories)
    }
    
    func interactor(didRetrieveCars cars: [Car]) {
        viewController?.presenter(didRetrieveCars: cars)
    }
    
    func interactor(didFailRetrieveCars error: Error) {
        viewController?.presenter(didFailRetrieveCars: error.localizedDescription)
    }
   
    func interactor(didFindCar car: Car, category: Category) {
        viewController?.presenter(didObtainCarId: car.id, category: category)
    }
    
    func interactor(didSelectCategory category: Category) {
        viewController?.presenter(didSelectCategory: category)
    }
}
