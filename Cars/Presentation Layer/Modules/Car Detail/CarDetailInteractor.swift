//
//  CarDetailInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarDetailInteractor: AnyObject {
    var carId: Int? { get }
    func viewDidLoad()
}

class CarDetailInteractorImplementation: CarDetailInteractor {
    var carId: Int?
    var category: Category?
    
    var presenter: CarDetailPresenter?
    
    private let carService = CarsServiceImplementation()
    
    func viewDidLoad() {
        
        do {
            if let carId = self.carId, let category = self.category {
                self.carService.getCar(with: carId, category: category) { result in
                    switch result {
                    case .success(let car):
                        if let car = car {
                            if car.name != "" {
                                self.presenter?.interactor(didRetrieveCar: car)
                            } else {
                                self.viewDidLoad()
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } catch {
            // Handle the error
            self.presenter?.interactor(didFailRetrieveCar: error)
        }
    }
}
