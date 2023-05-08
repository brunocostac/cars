//
//  CategorizedCarListInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import Foundation

protocol CategorizedCarListInteractor: AnyObject {
    var selectedCategory: Category? { get set }
    func viewDidAppear()
    func didSelectRow(at index: Int)
    func getCars(at category: Category)
}

class CategorizedCarListInteractorImplementation: CategorizedCarListInteractor {
   
    var presenter: CategorizedCarListPresenter?
    var selectedCategory: Category?
    private let carsService = CarsServiceImplementation()
    private var cars: [Car] = []
    
    func viewDidAppear()  {
        self.getCars(at: selectedCategory!)
    }
    
    func getCars(at category: Category) {
        do {
            self.carsService.getCars(with: Category(rawValue: category.rawValue)!) { result in
                switch result {
                case .success(let cars):
                    self.cars = cars
                    self.presenter?.interactor(didRetrieveCars: cars)
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            self.presenter?.interactor(didFailRetrieveCars: error)
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.cars.indices.contains(index) {
            self.presenter?.interactor(didFindCar: self.cars[index], category: selectedCategory!)
        }
    }
}
