//
//  LocationListCollectionViewCell.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import UIKit

class LocationListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.backgroundColor = UIColor.cellBackgroundColor()
        locationName.textColor = UIColor.textColor()
        colorView.layer.cornerRadius = 40
        locationImage.layer.cornerRadius = 40
    }

}
