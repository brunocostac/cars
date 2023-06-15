//
//  FavoritesListView.swift
//  Cars
//
//  Created by Bruno Costa on 06/06/23.
//

import UIKit
import SkeletonView

class FavoritesListView: UIView {
    
    // MARK: - Properties
    let tableView: UITableView = {
       let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
       tableView.rowHeight = 120
       tableView.separatorStyle = .none
       tableView.separatorColor = .clear
       tableView.backgroundColor = .systemGray6
       tableView.isSkeletonable = true
       return tableView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor = .systemGray6
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
