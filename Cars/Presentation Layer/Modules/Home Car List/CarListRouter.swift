//
//  CarListRouter.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit
import Foundation

protocol CarListRouter: AnyObject {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail(with id: Int, category: Category)
    func routeToCategorizedCarList(category: Category, instance: CarListViewController)
}

class CarListRouterImplementation: CarListRouter {
    func routeToDetail(with id: Int, category: Category) {
        let viewController = CarDetailViewController()
        CarDetailConfigurator.configureModule(carId: id, category: category,
                                                viewController: viewController)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func routeToCategorizedCarList(category: Category, instance: CarListViewController) {
        let viewController = CategorizedCarListViewController()
        viewController.delegate = instance
        CategorizedCarListConfigurator.configureModule(category: category,
                                                viewController: viewController)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    weak var navigationController: UINavigationController?

}
