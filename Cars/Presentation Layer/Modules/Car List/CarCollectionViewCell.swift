//
//  CarTableViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 19/04/23.
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
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
    
    public func updateImage(imageURL: URL) {
        activityIndicator.startAnimating()
    
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.carImage.image = image
                }
            }
        }.resume()
    }
}
