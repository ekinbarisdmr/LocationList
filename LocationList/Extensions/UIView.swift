//
//  UIView.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func border(borderWidth: CGFloat, borderColor: CGColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.masksToBounds = true
    }
}
