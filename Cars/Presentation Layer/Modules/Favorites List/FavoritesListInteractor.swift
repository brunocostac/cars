//
//  FavoritesListInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import Foundation

protocol FavoritesListInteractor: AnyObject {
    func viewDidAppear()
    func getCars()
    func didPressRemoveFavorite(indexPath: IndexPath)
}

class FavoritesListInteractorImplementation: FavoritesListInteractor {
   
    
    var presenter: FavoritesListPresenter?
    private var cars: [Car] = []

    func viewDidAppear()  {
        self.getCars()
    }
    
    func reloadData() {
        self.getCars()
    }
    
    func getCars() {
        FavoriteManager().fetchAll(completion: { cars, error in
            if let cars = cars {
                self.cars = cars
                self.presenter?.interactor(didRetrieveCars: cars)
            }
            if let error = error {
                print(error)
            }
        })
    }
    func didPressRemoveFavorite(indexPath: IndexPath) {
        self.removeFavorite(car: cars[indexPath.row])
    }
}

extension FavoritesListInteractorImplementation {
    func removeFavorite(car: Car) {
        FavoriteManager().remove(car: car) { car, error in
            if error != nil {
                // TODO: tratar erroz
            }
            if car != nil {
                self.reloadData()
            }
        }
    }
}
