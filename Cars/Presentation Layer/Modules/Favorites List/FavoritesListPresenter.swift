//
//  FavoritesListPresenter.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import Foundation
import UIKit


protocol FavoritesListPresenter: AnyObject {
    func interactor(didRetrieveCars cars: [Car])
}

class FavoritesListPresenterImplementation: FavoritesListPresenter {
    func interactor(didRetrieveCars cars: [Car]) {
        viewController?.presenter(didRetrieveCars: cars)
    }
    weak var viewController: FavoritesListPresenterOutput?
}
