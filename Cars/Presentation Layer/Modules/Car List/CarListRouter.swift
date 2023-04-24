//
//  CarListRouter.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

protocol CarListRouter: AnyObject {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail(with id: Int, carType: CarType)
}

class CarListRouterImplementation: CarListRouter {
    func routeToDetail(with id: Int, carType: CarType) {
        let viewController = CarDetailViewController()
        CarDetailConfigurator.configureModule(carId: id, carType: carType,
                                                viewController: viewController)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    weak var navigationController: UINavigationController?

}
