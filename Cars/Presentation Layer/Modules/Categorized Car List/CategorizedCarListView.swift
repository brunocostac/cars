//
//  CategorizedCarListView.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import UIKit

class CategorizedCarListView: UIView {
    
    let tableView: UITableView = {
       let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
       tableView.rowHeight = 180
       return tableView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
