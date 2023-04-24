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
    func didSelectCarType(at carType: Int)
}

class CarListInteractorImplementation: CarListInteractor {
    var presenter: CarListPresenter?
    
    private let carsService = CarsServiceImplementation()
    private var cars: [Car] = []
    private var selectedCarType: CarType?
    
    func viewDidLoad()  {
        do {
            self.selectedCarType = CarType.classic
            self.cars = try carsService.getCars(with: selectedCarType!)
            presenter?.interactor(didRetrieveCars: self.cars)
        } catch {
            presenter?.interactor(didFailRetrieveCars: error)
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.cars.indices.contains(index) {
            presenter?.interactor(didFindCar: self.cars[index], carType: selectedCarType!)
        }
    }
    
    func didSelectCarType(at carType: Int) {
        self.selectedCarType = CarType(rawValue: carType)
        do {
            self.cars = try carsService.getCars(with: selectedCarType!)
            presenter?.interactor(didRetrieveCars: self.cars)
        } catch {
            presenter?.interactor(didFailRetrieveCars: error)
        }
    }
}
