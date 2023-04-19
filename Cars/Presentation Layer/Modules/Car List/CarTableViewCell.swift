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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
