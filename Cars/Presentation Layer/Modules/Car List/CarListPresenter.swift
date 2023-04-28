//
//  CarListPresenter.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarListPresenter: AnyObject {
    func interactor(didFindCar car: Car, carType: CarType)
    func interactor(didRetrieveCars cars: [Car])
    func interactor(didRetrieveCarTypeName name: String)
    func interactor(didRetrieveCarType carTypeList: [[String: Any]])
    func interactor(didFailRetrieveCars error: Error)
}

class CarListPresenterImplementation: CarListPresenter {
    func interactor(didRetrieveCarTypeName name: String) {
        viewController?.presenter(didRetrieveCarTypeName: name)
    }
    
    func interactor(didRetrieveCarType carTypeList: [[String : Any]]) {
        viewController?.presenter(didRetrieverCarTypeList: carTypeList)
    }
    
    weak var viewController: CarListPresenterOutput?
    
    func interactor(didRetrieveCars cars: [Car]) {
        viewController?.presenter(didRetrieveCars: cars)
    }
    
    func interactor(didFailRetrieveCars error: Error) {
        viewController?.presenter(didFailRetrieveCars: error.localizedDescription)
    }
   
    func interactor(didFindCar car: Car, carType: CarType) {
        viewController?.presenter(didObtainCarId: car.id, carType: carType)
    }
}
