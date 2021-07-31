//
//  LocationDetailTableViewCell.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 26.06.2021.
//

import UIKit

class LocationDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationDescription: UILabel!
    @IBOutlet weak var locationDetail: UILabel!
    @IBOutlet weak var backButton: CustomButton!
    @IBOutlet weak var routeButton: CustomButton!
    
    var back: () -> ()  = { }
    var route: () -> () = { }

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.colorView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 70)
        }
        colorView.backgroundColor = UIColor.cellBackgroundColor()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func backButton(_ sender: Any) {
        back()
    }
    
    @IBAction func routeButton(_ sender: Any) {
        route()
    }
    
}
