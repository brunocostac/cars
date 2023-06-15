//
//  FavoritesListPresenter.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import Foundation
import UIKit


protocol FavoritesListPresenter: AnyObject {
}

class FavoritesListPresenterImplementation: FavoritesListPresenter {
    weak var viewController: FavoritesListPresenterOutput?
}
