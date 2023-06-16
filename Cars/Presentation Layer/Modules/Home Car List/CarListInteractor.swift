//
//  CarListInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation


protocol CarListInteractor: AnyObject {
    var carsRetrieved: Bool  {get set}
    func viewDidLoad()
    func reloadData()
    func getSelectedCategoryName()
    func didSelectCar(at index: Int)
    func didSelectCategory(at category: Int)
    func didPressFavoriteButton(at index: Int)
    func didPressCategoryButton()
    func didPressExploreButton()
    func getCars(with: Category)
    func checkIsFavorite(car: Car) -> Bool
}

class CarListInteractorImplementation: CarListInteractor {
    var presenter: CarListPresenter?
    
    private let carsService = CarsServiceImplementation()
    private var cars: [Car] = []
    private var favoriteManager: FavoriteManager?
    private var selectedCategory: Category = Category.newCars
    var carsRetrieved = false
    private var categories: [[String: Any]] = []
    
    
    init() {
        self.favoriteManager = FavoriteManager()
    }
    
    func viewDidLoad()  {
        self.selectDefaultCategory()
        self.getCars(with: selectedCategory)
        self.getCategories()
        self.getSelectedCategoryName()
    }
    
    func reloadData() {
        self.viewDidLoad()
    }
    
    func selectDefaultCategory() {
        self.selectedCategory = Category.newCars
    }
    
    func getSelectedCategoryName() {
        self.presenter?.interactor(didRetrieveCategoryName: self.selectedCategory.name)
    }
    
    func getCategories()  {
        self.categories = []
        let classicCategory = ["id": Category.classic.id, "name": Category.classic.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Rolls_Royce_Phantom.png"] as [String : Any]
        categories.append(classicCategory)

        let luxuryCategory = ["id": Category.luxury.id, "name": Category.luxury.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Leblanc_Mirabeau.png"] as [String : Any]
        categories.append(luxuryCategory)

        let sportsCategory = ["id": Category.sports.id, "name": Category.sports.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Audi_Spyder.png"] as [String : Any]
        categories.append(sportsCategory)
        
        let newCarsCategory = ["id": Category.newCars.id, "name": Category.newCars.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Bugatti_Veyron.png"] as [String : Any]
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
    
    func didPressExploreButton() {
        self.getCategories()
        self.presenter?.interactor(didSelectAllCategories: categories)
    }
    
    func didPressCategoryButton() {
        self.presenter?.interactor(didSelectCategory: selectedCategory)
    }
    
    func didSelectCar(at index: Int) {
        if self.cars.indices.contains(index) {
            self.presenter?.interactor(didFindCar: self.cars[index], category: selectedCategory)
        }
    }
    
    func didSelectCategory(at category: Int) {
        let selectedCategory: Category = Category(rawValue: category)!
        self.presenter?.interactor(didSelectCategory: selectedCategory)
    }
}

extension CarListInteractorImplementation {
    func didPressFavoriteButton(at index: Int) {
        let car = cars[index]
        let isFavorite = self.checkIsFavorite(car: cars[index])
        self.toggleFavorite(car: car, isFavorite: isFavorite)
    }
    
    func toggleFavorite(car: Car, isFavorite: Bool) {
        if !isFavorite {
            self.saveFavorite(car: car)
        } else {
            self.removeFavorite(car: car)
        }
    }
    
    func saveFavorite(car: Car) {
        self.favoriteManager?.save(car: car) { car, error in
            if error != nil {
                // TODO: tratar erro
            }
            if car != nil {
                self.reloadData()
            }
        }
    }
    
    func removeFavorite(car: Car) {
        self.favoriteManager?.remove(car: car) { car, error in
            if error != nil {
                // TODO: tratar erroz
            }
            if car != nil {
                self.reloadData()
            }
        }
    }
    
    func checkIsFavorite(car: Car) -> Bool{
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
