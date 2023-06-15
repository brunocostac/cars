//
//  FavoritesLitRouterImplementation.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import UIKit

protocol FavoritesListRouter: AnyObject {
    var navigationController: UINavigationController? { get set }
}

class FavoritesListRouterImplementation: FavoritesListRouter {
    weak var navigationController: UINavigationController?
}
