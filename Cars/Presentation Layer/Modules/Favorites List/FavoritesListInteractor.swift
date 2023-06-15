//
//  FavoritesListInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import Foundation

protocol FavoritesListInteractor: AnyObject {
    func viewDidLoad()
}

class FavoritesListInteractorImplementation: FavoritesListInteractor {
    var presenter: FavoritesListPresenter?
    var categories: [[String : Any]] = []

    func viewDidLoad()  {
        
    }
}
