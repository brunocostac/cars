//
//  CarDetailInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarDetailInteractor: AnyObject {
    var carId: Int? { get }
    func viewWillAppear()
}

class CarDetailInteractorImplementation: CarDetailInteractor {
    var carId: Int?
    var category: Category?
    
    var presenter: CarDetailPresenter?
    
    private let carService = CarsServiceImplementation()
    
    func viewWillAppear() {
        
        do {
            self.carService.getCar(with: self.carId!, category: self.category!) { result in
                switch result {
                case .success(let car):
                    self.presenter?.interactor(didRetrieveCar: car!)
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            // Handle the error
            self.presenter?.interactor(didFailRetrieveCar: error)
        }
    }
}
