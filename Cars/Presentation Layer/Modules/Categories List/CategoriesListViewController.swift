//
//  CategoriesListViewController.swift
//  Cars
//
//  Created by Bruno Costa on 30/05/23.
//

import UIKit
import SkeletonView
import ProgressHUD

protocol CategoriesListPresenterOutput: AnyObject {
    func presenter(didRetrieveCategories categories: [[String : Any]])
    func presenter(didSelectCategory category: Category)
}

class CategoriesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var interactor: CategoriesListInteractor?
    var router: CategoriesListRouter?
    var categoriesView: CategoriesListView?
    
    var categories: [[String : Any]] = []
    
    override func loadView() {
        title = "Categories"
        view = categoriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.showAnimatedGradientInView()
        self.interactor?.viewDidLoad()
    }
    
    func setupTableView() {
        self.categoriesView?.tableView.delegate = self
        self.categoriesView?.tableView.dataSource = self
        self.categoriesView?.tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: "CategoriesTableViewCell")
        self.categoriesView?.tableView.rowHeight = 120
    }
    
    func showAnimatedGradientInView() {
        view.isSkeletonable = true
        DispatchQueue.main.async {
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as? CategoriesTableViewCell else {
            return UITableViewCell()
        }
        cell.label.text = self.categories[indexPath.row]["name"] as! String
        cell.updateImage(imageURL: self.categories[indexPath.row]["image_url"] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < categories.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (self.categoriesView?.tableView.bounds.size.width)!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.interactor?.didSelectCategory(at: indexPath.row)
    }
}

extension CategoriesListViewController: CategoriesListPresenterOutput {
    func presenter(didSelectCategory category: Category) {
        self.router?.navigationController = self.navigationController 
        self.router?.routeToCategorizedCarList(category: category)
    }
    
    func presenter(didRetrieveCategories categories: [[String : Any]]) {
        ProgressHUD.show("Loading...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view.hideSkeleton()
            self.categories = categories
            self.categoriesView?.tableView.reloadData()
            ProgressHUD.dismiss()
        }
    }
}
