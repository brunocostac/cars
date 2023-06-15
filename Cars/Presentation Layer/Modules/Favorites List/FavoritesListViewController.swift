//
//  FavoritesListViewController.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import UIKit


protocol FavoritesListPresenterOutput: AnyObject {
    
}

class FavoritesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesView: FavoritesListView?
    var interactor: FavoritesListInteractor?
    var router: FavoritesListRouter?
    
    override func loadView() {
        self.title = "Garage"
        self.view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
     }
    
    func setupTableView() {
        self.favoritesView?.tableView.delegate = self
        self.favoritesView?.tableView.dataSource = self
        self.favoritesView?.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
        self.favoritesView?.tableView.rowHeight = 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(title: "Carr", imageURL: URL(string: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Bugatti_Veyron.png")!, price: "$ 1000")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
}

extension FavoritesListViewController: FavoritesListPresenterOutput {
    
}
