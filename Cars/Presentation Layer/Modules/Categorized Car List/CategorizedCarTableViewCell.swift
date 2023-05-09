//
//  CategorizedCarTableViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 03/05/23.
//

import UIKit

class CategorizedCarTableViewCell: UITableViewCell {
    
    let carNameLabel: UILabel = {
        let carNameLabel = UILabel()
        carNameLabel.translatesAutoresizingMaskIntoConstraints = false
        carNameLabel.font = UIFont(name: "Avenir", size: 20)
        carNameLabel.textColor = .black
        return carNameLabel
    }()
    
    let carPriceLabel: UILabel = {
        let carPriceLabel = UILabel()
        carPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        carPriceLabel.font = UIFont(name: "Avenir", size: 14)
        carPriceLabel.textColor = .darkGray
        return carPriceLabel
    }()
    
    let carImageView: UIImageView = {
       let carImageView = UIImageView()
       carImageView.translatesAutoresizingMaskIntoConstraints = false
       carImageView.contentMode = .scaleAspectFit
       return carImageView
    }()
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .horizontal
       stackView.spacing = 10 // Set spacing between labels
       return stackView
    }()
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        self.separatorInset = .zero
        addSubview(carImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(carNameLabel)
        stackView.addArrangedSubview(carPriceLabel)

        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            carImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            carImageView.heightAnchor.constraint(equalToConstant: 140),
            
            stackView.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
    }
    
    
    func configure(title: String, imageURL: URL, price: String) {
        
        self.carNameLabel.text = title
        self.carPriceLabel.text = "$ \(price)"
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.carImageView.image = image
                }
            }
        }.resume()
    }
}
