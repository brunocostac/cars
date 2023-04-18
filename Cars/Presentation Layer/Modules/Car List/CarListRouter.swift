//
//  CarListRouter.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

protocol CarListRouter: AnyObject {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail(with id: String)
}

class CarListRouterImplementation: CarListRouter {
    weak var navigationController: UINavigationController?
    
    func routeToDetail(with id: String) {
        let viewController = CarDetailViewController()
        CarDetailConfigurator.configureModule(carId: id,
                                                viewController: viewController)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
