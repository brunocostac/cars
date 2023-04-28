//
//  CarTypeCollectionViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 27/04/23.
//

import UIKit

class CarTypeCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.cornerRadius = 10 // You can adjust the corner radius value to your preference
        layer.masksToBounds = true
    }
    
    public func updateImage(imageURL: String) {

        let image_URL = URL(string: imageURL)!
        
        URLSession.shared.dataTask(with: image_URL) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
