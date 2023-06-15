//
//  CategoriesListRouter.swift
//  Cars
//
//  Created by Bruno Costa on 30/05/23.
//

import Foundation
import UIKit

protocol CategoriesListRouter: AnyObject {
    func routeToCategorizedCarList(category: Category)
    var navigationController: UINavigationController? { get set }
}

class CategoriesListRouterImplementation: CategoriesListRouter {
    weak var navigationController: UINavigationController?
    
    func routeToCategorizedCarList(category: Category) {
        let viewController = CategorizedCarListViewController()
        CategorizedCarListConfigurator.configureModule(category: category, viewController: viewController)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
