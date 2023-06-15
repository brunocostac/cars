//
//  FavoritesListConfigurator.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import UIKit

class FavoritesListConfigurator {
    
    static func configureModule(viewController: FavoritesListViewController) {
        let view = FavoritesListView()
        let router = FavoritesListRouterImplementation()
        let interactor = FavoritesListInteractorImplementation()
        let presenter = FavoritesListPresenterImplementation()
        
        viewController.favoritesView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
        router.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
