//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//
import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offSet  //Here you control x and y
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius //Here your control your blur
        layer.masksToBounds =  false
    }
    
    func cornerRadius(_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.clipsToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension CALayer {
    func applyRoundCornerMaskWith(radius: CGFloat, corners: UIRectCorner) {
        let path: UIBezierPath = UIBezierPath.init(roundedRect: self.bounds,
                                                  byRoundingCorners: corners,
                                                  cornerRadii: CGSize(width: radius,
                                                                      height: radius))
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        layer.frame = self.bounds
        self.mask = layer
    }
}
