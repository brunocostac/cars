//
//  CarTableViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 19/04/23.
//

import UIKit
import SDWebImage
import SkeletonView

protocol HomeCarCollectionViewCellDelegate: AnyObject {
    func didPressFavoriteButton(indexPath: IndexPath)
}

class HomeCarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: HomeCarCollectionViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.contentView.isUserInteractionEnabled = true
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if let indexPath = indexPath {
            self.delegate?.didPressFavoriteButton(indexPath: indexPath)
        }
    }
    
    public func updateImage(imageURL: URL) {
        self.carImage.sd_setImage(with: imageURL)
    }
    
    public func configure(name: String, description: String, isFavorite: Bool) {
        self.nameLabel.text = name
        self.descLabel.text = description
        self.favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
    }
}
