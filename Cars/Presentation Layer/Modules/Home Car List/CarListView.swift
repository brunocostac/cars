//
//  CarListView.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit
import SkeletonView

class CarListView: UIView {
    
    lazy var categoryView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineView: UIView = {
       let view = UIView()
       view.backgroundColor = .opaqueSeparator
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.textColor = .black
        label.text = "Explore"
        label.isSkeletonable = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var lineViewTwo: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.textColor = .black
        label.text = "New Cars"
        label.isSkeletonable = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        cv.isSkeletonable = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.tag = 1
        return cv
    }()
    
    let carCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        cv.backgroundView = nil
        cv.isSkeletonable = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.tag = 2
        return cv
    }()
    
    let exploreButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "See all >"
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        button.setTitleColor(.purple, for: .normal)
        button.isSkeletonable = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "See all >"
        button.titleLabel?.font = UIFont(name: "Avenir", size: 14)
        button.setTitleColor(.purple, for: .normal)
        button.isSkeletonable = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup
extension CarListView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.backgroundColor =  UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        self.addSubview(categoryView)
        self.addSubview(lineView)
        self.categoryView.addSubview(categoryLabel)
        self.categoryView.addSubview(exploreButton)
        self.addSubview(categoryCollectionView)
        self.addSubview(titleView)
        self.addSubview(lineViewTwo)
        self.titleView.addSubview(titleLabel)
        self.titleView.addSubview(categoryButton)
        self.addSubview(carCollectionView)
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            categoryView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            categoryView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            categoryView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 2),
            lineView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            lineView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            lineView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: self.categoryView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: self.categoryView.leadingAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            exploreButton.centerYAnchor.constraint(equalTo: self.categoryLabel.centerYAnchor),
            exploreButton.trailingAnchor.constraint(equalTo: self.categoryView.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: self.categoryView.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.categoryCollectionView.bottomAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            titleView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.titleView.leadingAnchor, constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            lineViewTwo.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 2),
            lineViewTwo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            lineViewTwo.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            lineViewTwo.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        NSLayoutConstraint.activate([
           categoryButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
           categoryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            carCollectionView.topAnchor.constraint(equalTo:  self.titleView.bottomAnchor, constant: 10),
            carCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            carCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            carCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}
