//
//  CarListView.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit
import SkeletonView

class CarListView: UIView {
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 25)
        label.textColor = .darkGray
        label.text = "Explore"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 25)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryCollectionView: UICollectionView = {
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
    
    func setupSkeleton() {
        DispatchQueue.main.async {
            self.isSkeletonable = true
            self.carCollectionView.backgroundView = nil
            self.carCollectionView.isSkeletonable = true
            self.categoryCollectionView.isSkeletonable = true
        }
    }
    
    func stopCarCollectionSkeleton() {
        DispatchQueue.main.async {
            self.carCollectionView.stopSkeletonAnimation()
            self.carCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
    
    func stopCategoryCollectionSkeleton() {
        DispatchQueue.main.async {
            self.categoryCollectionView.stopSkeletonAnimation()
            self.categoryCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadCategoriesCollectionView() {
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
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
        self.addSubview(categoryCollectionView)
        self.addSubview(titleLabel)
        self.addSubview(carCollectionView)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            categoryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
          
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.categoryCollectionView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            carCollectionView.topAnchor.constraint(equalTo:  self.titleLabel.bottomAnchor, constant: 10),
            carCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            carCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            carCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
