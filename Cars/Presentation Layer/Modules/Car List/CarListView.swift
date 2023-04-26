//
//  CarListView.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

protocol SegmentedControlDelegate {
    func didSegmentedValueChanged(selectedSegmentIndex: Int)
}

class CarListView: UIView {
    
    var delegate: SegmentedControlDelegate?
    
    // MARK: - Properties
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Classic", "Luxury", "Sports"])
       segmentedControl.selectedSegmentIndex = 0
       segmentedControl.translatesAutoresizingMaskIntoConstraints = false
       return segmentedControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UI Setup
extension CarListView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor = UIColor(red: 0.9765, green: 0.9765, blue: 0.9765, alpha: 1.0)
        self.addSubview(segmentedControl)
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 10),
        ])
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        self.delegate?.didSegmentedValueChanged(selectedSegmentIndex: sender.selectedSegmentIndex)
    }
}
