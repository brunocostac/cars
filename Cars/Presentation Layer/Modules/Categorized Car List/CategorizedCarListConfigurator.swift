//
//  CategorizedCarConfigurator.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import UIKit

class CategorizedCarListConfigurator {
    
    static func configureModule(category: Category, viewController: CategorizedCarListViewController) {
        let view = CategorizedCarListView()
        let router = CategorizedCarListRouterImplementation()
        let interactor = CategorizedCarListInteractorImplementation()
        let presenter = CategorizedCarListPresenterImplementation()
        
        viewController.selectedCategory = category
        viewController.categorizedCarsView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
        router.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
