//
//  CarDetailConfigurator.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation

class CarDetailConfigurator {
    
    static func configureModule(carId: Int, category: Category,
                                viewController: CarDetailViewController) {
        let view = CarDetailView()
        let router = CarDetailRouterImplementation()
        let interactor = CarDetailInteractorImplementation()
        let presenter = CarDetailPresenterImplementation()
            
        interactor.carId = carId
        interactor.category = category
        
        viewController.carDetailView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
    }
}
