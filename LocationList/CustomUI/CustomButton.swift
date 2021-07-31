//
//  CustomButton.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 26.06.2021.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addCornerRadius(radius: 20)
        
    }

}

class CircleView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addCornerRadius(radius: 20)
        
    }

}
