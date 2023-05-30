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
        carNameLabel.font = UIFont(name: "Avenir-Black", size: 14)
        carNameLabel.textColor = .black
        carNameLabel.isSkeletonable = true
        return carNameLabel
    }()
    
    let costIcon: UIImageView = {
        let costIcon = UIImageView()
        costIcon.translatesAutoresizingMaskIntoConstraints = false
        costIcon.image = UIImage(systemName: "banknote")
        costIcon.tintColor = .darkGray
        costIcon.isSkeletonable = true
        return costIcon
    }()
    
    let carPriceLabel: UILabel = {
        let carPriceLabel = UILabel()
        carPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        carPriceLabel.font = UIFont(name: "Avenir", size: 14)
        carPriceLabel.textColor = .darkGray
        carPriceLabel.text = "$ 1000"
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
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10 // Set spacing between labels
        stackView.isSkeletonable = true
        return stackView
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(carImageView)
        contentView.addSubview(verticalStackView)
        
        horizontalStackView.addArrangedSubview(costIcon)
        horizontalStackView.addArrangedSubview(carPriceLabel)
        verticalStackView.addArrangedSubview(carNameLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            carImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            carImageView.widthAnchor.constraint(equalToConstant: self.frame.size.width/2),
            carImageView.heightAnchor.constraint(equalToConstant: 100),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 0),
            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 0),
            
            costIcon.widthAnchor.constraint(equalToConstant: 18),
            costIcon.heightAnchor.constraint(equalToConstant: 18),
            
            
            verticalStackView.centerYAnchor.constraint(equalTo: carImageView.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: carImageView.leadingAnchor, constant: -10)
        ])
    }
    
    func configure(title: String, imageURL: URL, price: String) {
        self.carNameLabel.text = title
        
        if let formattedDollarValue = formatToDollar(price) {
            self.carPriceLabel.text = "$ \(String(describing: formatToDollar(formattedDollarValue)))"
        }
        
        self.carImageView.sd_setImage(with: imageURL)
    }
    
    func formatToDollar(_ numberString: String) -> String? {
        // Remove any existing punctuation from the number string
        let cleanedNumberString = numberString.replacingOccurrences(of: ".", with: "")
        
        // Convert the cleaned string to a number
        guard let number = Double(cleanedNumberString) else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"  // Set the currency code if needed
        formatter.locale = Locale.current  // Use the current locale
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        }
        
        return nil
    }
}
