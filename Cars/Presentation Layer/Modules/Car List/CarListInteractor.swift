//
//  CarListInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation


protocol CarListInteractor: AnyObject {
    func viewDidLoad()
    func didSelectRow(at index: Int)
}

class CarListInteractorImplementation: CarListInteractor {
    var presenter: CarListPresenter?
    
    private let carsService = CarsServiceImplementation()
    private var cars: [Car] = []
    
    func viewDidLoad()  {
        do {
            self.cars = try carsService.getCars()
            
            presenter?.interactor(didRetrieveCars: self.cars)
        } catch {
            presenter?.interactor(didFailRetrieveCars: error)
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.cars.indices.contains(index) {
            presenter?.interactor(didFindCar: self.cars[index])
        }
    }
}
