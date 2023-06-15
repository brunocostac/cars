//
//  CategoriesListPresenterImplementation.swift
//  Cars
//
//  Created by Bruno Costa on 30/05/23.
//

import Foundation
import UIKit

protocol CategoriesListPresenter: AnyObject {
    func interactor(didRetrieveCategories categories: [[String : Any]])
    func interactor(didSelectCategory category: Category)
}

class CategoriesListPresenterImplementation: CategoriesListPresenter {
    func interactor(didSelectCategory category: Category) {
        viewController?.presenter(didSelectCategory: category)
    }
    
    func interactor(didRetrieveCategories categories: [[String : Any]]) {
        viewController?.presenter(didRetrieveCategories: categories)
    }
    
    weak var viewController: CategoriesListPresenterOutput?
}
