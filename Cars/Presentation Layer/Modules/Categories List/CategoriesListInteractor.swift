//
//  CategoriesListRouterImplementation.swift
//  Cars
//
//  Created by Bruno Costa on 30/05/23.
//

import UIKit

protocol CategoriesListInteractor: AnyObject {
    func viewDidLoad()
    func didSelectCategory(at category: Int)
    func getCategories()
}

class CategoriesListInteractorImplementation: CategoriesListInteractor {
    var presenter: CategoriesListPresenter?
    var categories: [[String : Any]] = []

    func viewDidLoad()  {
        self.getCategories()
    }
    
    func didSelectCategory(at category: Int) {
        let selectedCategory: Category = Category(rawValue: category)!
        self.presenter?.interactor(didSelectCategory: selectedCategory)
    }
    
    func getCategories()  {
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
}
