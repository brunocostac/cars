//
//  CarDetailInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

protocol CarDetailInteractor: AnyObject {
    var carId: Int? { get }
    func viewDidAppear()
    func didPressFavoriteButton(car: Car)
    func didCheckCarIsFavorite()
}

class CarDetailInteractorImplementation: CarDetailInteractor {
    var carId: Int?
    var category: Category?
    private var car: Car?
    var presenter: CarDetailPresenter?
    private var favoriteManager: FavoriteManager?
    
    private let carService = CarsServiceImplementation()
    
    init() {
        self.favoriteManager = FavoriteManager()
    }
    
    func viewDidAppear() {
        self.getCar()
        self.didCheckCarIsFavorite()
    }
    
    func didCheckCarIsFavorite() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let car = self.car {
                let isFavorite = self.checkIsFavorite(car: car)
                self.presenter?.interactor(didRetrieveCarStatus: isFavorite)
            }
        }
    }
    
    func didPressFavoriteButton(car: Car) {
        self.toggleFavorite(car: car)
    }
    
    func getCar()  {
        do {
            if let carId = self.carId, let category = self.category {
                self.carService.getCar(with: carId, category: category) { result in
                    switch result {
                    case .success(let car):
                        if let car = car {
                            self.car = car
                            if car.name != "" {
                                self.presenter?.interactor(didRetrieveCar: car)
                            } else {
                                self.viewDidAppear()
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
    
    func toggleFavorite(car: Car) {
        let isFavorite = self.checkIsFavorite(car: car)
        !isFavorite ? self.saveFavorite(car: car) : self.removeFavorite(car: car)
    }
    
    func saveFavorite(car: Car) {
        self.favoriteManager?.save(car: car) { car, error in
            if error != nil {
                // TODO: tratar erro
            }
            if car != nil {
                self.presenter?.interactor(didRetrieveCarStatus: true)
            }
        }
    }
    
    func removeFavorite(car: Car) {
        self.favoriteManager?.remove(car: car) { car, error in
            if error != nil {
                // TODO: tratar erroz
            }
            if car != nil {
                self.presenter?.interactor(didRetrieveCarStatus: false)
            }
        }
    }
    
    func checkIsFavorite(car: Car) -> Bool {
        var isFavorite = false
        
        self.favoriteManager?.fetch(car: car) { movie, error in
            if error != nil {
                isFavorite = false
            }
            if movie != nil {
                isFavorite = true
            }
        }
        return isFavorite
    }

}
