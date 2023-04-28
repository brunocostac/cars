//
//  CarListView.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

class CarListView: UIView {
    
    // MARK: - Properties
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.textColor = .darkGray
        label.text = "Categories"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let carTypeListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.tag = 1
        return cv
    }()
    
    let carCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.tag = 2
        return cv
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadTypeListCarCollectionView() {
        DispatchQueue.main.async {
            self.carTypeListCollectionView.reloadData()
        }
    }
    
    public func reloadCarCollectionView() {
        DispatchQueue.main.async {
            self.carCollectionView.reloadData()
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
        self.addSubview(categoryLabel)
        self.addSubview(carTypeListCollectionView)
        self.addSubview(titleLabel)
        self.addSubview(carCollectionView)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            carTypeListCollectionView.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 10),
            carTypeListCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            carTypeListCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            carTypeListCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
     
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: carTypeListCollectionView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            carCollectionView.topAnchor.constraint(equalTo:  titleLabel.bottomAnchor, constant: 10),
            carCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            carCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            carCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
