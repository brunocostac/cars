//
//  CarListInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation


protocol CarListInteractor: AnyObject {
    var carsRetrieved: Bool  {get set}
    var shouldReloadData: Bool {get set}
    func initializeData()
    func reloadData()
    func didSelectRow(at index: Int)
    func didSelectCategory(at category: Int)
    func getCars(with: Category)
}

class CarListInteractorImplementation: CarListInteractor {
    var presenter: CarListPresenter?
    
    private let carsService = CarsServiceImplementation()
    private var cars: [Car] = []
    private var selectedCategory: Category = Category.newCars
    var carsRetrieved = false
    var shouldReloadData: Bool = false
    
    func initializeData()  {
        self.selectDefaultCategory()
        self.getSelectedCategoryName()
        self.getCars(with: selectedCategory)
        self.getCategories()
    }
    
    func reloadData() {
        self.selectDefaultCategory()
        self.initializeData()
    }
    
    func selectDefaultCategory() {
        self.selectedCategory = Category.newCars
    }
    
    func getSelectedCategoryName() {
        self.presenter?.interactor(didRetrieveCategoryName: self.selectedCategory.name)
    }
    
    func getCategories()  {
        var categories: [[String: Any]] = []

        let classicCategory = ["id": Category.classic.id, "name": Category.classic.name, "image_url": "https://img.hmn.com/900x0/stories/2018/08/301531.jpg"] as [String : Any]
        categories.append(classicCategory)

        let luxuryCategory = ["id": Category.luxury.id, "name": Category.luxury.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Bugatti_Veyron.png"] as [String : Any]
        categories.append(luxuryCategory)

        let sportsCategory = ["id": Category.sports.id, "name": Category.sports.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Audi_Spyder.png"] as [String : Any]
        categories.append(sportsCategory)
        
        let newCarsCategory = ["id": Category.newCars.id, "name": Category.newCars.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Lexus_LFA.png"] as [String : Any]
        categories.append(newCarsCategory)
        
        self.presenter?.interactor(didRetrieveCategories: categories)
    }
    
    func getCars(with category: Category) {
        
        do {
            self.carsService.getCars(with: category) { result in
                switch result {
                case .success(let cars):
                    self.cars = cars
                    self.presenter?.interactor(didRetrieveCars: self.cars)
                case .failure(let error):
                    self.presenter?.interactor(didFailRetrieveCars: error)
                }
            }
        } catch {
            self.presenter?.interactor(didFailRetrieveCars: error)
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.cars.indices.contains(index) {
            self.presenter?.interactor(didFindCar: self.cars[index], category: selectedCategory)
        }
    }
    
    func didSelectCategory(at category: Int) {
        let selectedCategory: Category = Category(rawValue: category)!
        self.presenter?.interactor(didSelectCategory: selectedCategory)
    }
}
