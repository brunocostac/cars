//
//  CategorizedCarListRouter.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import UIKit

protocol CategorizedCarListRouter: AnyObject {
    var navigationController: UINavigationController? { get set}
    func routeToDetail(with id: Int, category: Category)
}

class CategorizedCarListRouterImplementation: CategorizedCarListRouter {
    weak var navigationController: UINavigationController?
    
    
    func routeToDetail(with id: Int, category: Category) {
        let viewController = CarDetailViewController()
        
        CarDetailConfigurator.configureModule(carId: id, category: category,
                                                viewController: viewController)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
