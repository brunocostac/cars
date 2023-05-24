//
//  CategorizedCarTableViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import UIKit
import SDWebImage

class CategorizedCarTableViewCell: UITableViewCell {

    let carNameLabel: UILabel = {
        let carNameLabel = UILabel()
        carNameLabel.translatesAutoresizingMaskIntoConstraints = false
        carNameLabel.font = UIFont(name: "Avenir", size: 20)
        carNameLabel.textColor = .black
        carNameLabel.isSkeletonable = true
        return carNameLabel
    }()
    
    let carPriceLabel: UILabel = {
        let carPriceLabel = UILabel()
        carPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        carPriceLabel.font = UIFont(name: "Avenir", size: 14)
        carPriceLabel.textColor = .darkGray
        carPriceLabel.isSkeletonable = true
        return carPriceLabel
    }()
    
    let carImageView: UIImageView = {
       let carImageView = UIImageView()
       carImageView.translatesAutoresizingMaskIntoConstraints = false
       carImageView.contentMode = .scaleAspectFit
       carImageView.isSkeletonable = true
       return carImageView
    }()
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .horizontal
       stackView.spacing = 10 // Set spacing between labels
       stackView.isSkeletonable = true
       return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isSkeletonable = true
        self.isUserInteractionEnabled = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(carImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(carNameLabel)
        stackView.addArrangedSubview(carPriceLabel)
        
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            carImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            carImageView.heightAnchor.constraint(equalToConstant: 140),
            
            stackView.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }
   
    func configure(title: String, imageURL: URL, price: String) {
        self.carNameLabel.text = title
        self.carPriceLabel.text = "$ \(price)"
        self.carImageView.sd_setImage(with: imageURL)
    }
}
