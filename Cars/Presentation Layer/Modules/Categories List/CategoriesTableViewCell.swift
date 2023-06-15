//
//  CategoriesTableViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 31/05/23.
//

import UIKit
import SDWebImage
import SkeletonView

class CategoriesTableViewCell: UITableViewCell {
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
      }
    
    let label: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont(name: "Avenir-Heavy", size: 30)
       label.textColor = .white
       label.isSkeletonable = true
       return label
    }()
    
    let carImageView: UIImageView = {
        let carImageView = UIImageView()
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        carImageView.layer.opacity = 0.8
        carImageView.contentMode = .scaleAspectFit
        carImageView.isSkeletonable = true
        return carImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isSkeletonable = true
        self.isUserInteractionEnabled = true
        self.selectionStyle = .none
        self.backgroundColor = .darkGray
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(carImageView)
        contentView.addSubview(label)
    
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            carImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            carImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func updateImage(imageURL: String) {
        if let imageURL = URL(string: imageURL) {
            self.carImageView.sd_setImage(with: imageURL)
        }
    }
}
