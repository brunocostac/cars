//
//  CarTableViewCell.swift
//  Cars
//
//  Created by Bruno Costa on 19/04/23.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func updateImage(imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.carImage.image = image
                }
            }
        }.resume()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
