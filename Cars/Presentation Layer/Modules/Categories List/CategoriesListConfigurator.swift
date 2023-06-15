//
//  CategoriesListConfigurator.swift
//  Cars
//
//  Created by Bruno Costa on 30/05/23.
//

import UIKit

class CategoriesListConfigurator {
    
    static func configureModule(viewController: CategoriesListViewController) {
        let view = CategoriesListView()
        let router = CategoriesListRouterImplementation()
        let interactor = CategoriesListInteractorImplementation()
        let presenter = CategoriesListPresenterImplementation()
        
        viewController.categoriesView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
        router.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
