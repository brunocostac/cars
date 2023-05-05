//
//  CarListConfigurator.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

class CarListConfigurator {
    
    static func configureModule(viewController: CarListViewController) {
        let view = CarListView()
        let router = CarListRouterImplementation()
        let interactor = CarListInteractorImplementation()
        let presenter = CarListPresenterImplementation()
        
        viewController.carsView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
        router.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
