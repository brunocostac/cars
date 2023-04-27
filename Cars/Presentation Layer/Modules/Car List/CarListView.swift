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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = segmentedControl.titleForSegment(at: 0)
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadTableView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UI Setup
extension CarListView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        self.addSubview(segmentedControl)
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        self.titleLabel.text = sender.titleForSegment(at: sender.selectedSegmentIndex)
        self.delegate?.didSegmentedValueChanged(selectedSegmentIndex: sender.selectedSegmentIndex)
    }
}
