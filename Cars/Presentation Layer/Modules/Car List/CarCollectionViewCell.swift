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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.cornerRadius = 10 // You can adjust the corner radius value to your preference
        layer.masksToBounds = true
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
