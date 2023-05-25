//
//  CarTypeCollectionViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 27/04/23.
//

import UIKit
import SDWebImage
import SkeletonView

class CategoryCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func startAnimation() {
        self.imageView.showAnimatedSkeleton()
        self.titleLabel.showAnimatedSkeleton()
    }
    
    func hideAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.imageView.hideSkeleton()
            self.titleLabel.hideSkeleton()
        }
    }
    
    public func updateImage(imageURL: String) {
        self.imageView.sd_setImage(with: URL(string: imageURL))
    }
}
