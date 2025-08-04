//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

enum Position {

    case top
    case left
    case bottom
    case right

}

extension UIButton {

    func configureButtonWithTitle(title: String, titleColor: UIColor, backgroundColor: UIColor, font: FontType, size: FontSize) {

        self.titleLabel?.font = UIFont.poppins(font: font, size: size)
        self.setTitle(title.localized(), for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 8.0
    }
    
   /* func configureButtonWithTitle(title: String, titleColor: UIColor, backgroundColor: UIColor, font: FontType, family: FontFamily, size: FontSize) {
        
        self.titleLabel?.font = UIFont.font(family: family.rawValue, type: font.rawValue, size: size.rawValue)
        self.setTitle(title.localized(), for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 8.0
    } */
    
    func configureButtonWithTitle(title: String, titleColor: UIColor, backgroundColor: UIColor, font: FontStyle) {
        
        self.titleLabel?.font = UIFont.font(family: font.family.rawValue, type: font.type.rawValue, size: font.size.rawValue)
        self.setTitle(title.localized(), for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        //self.layer.cornerRadius = 8.0
    }
    
    func adjustInsetForTextAndImageButton(imagePosition: Position, textPosition: Position) {

        switch (imagePosition, textPosition) {

        case (.left, .right):

            self.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: (titleLabel?.frame.width)!)

            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)!, bottom: 0, right: 5)

            self.contentHorizontalAlignment = .left

            self.contentVerticalAlignment = .center

        case (.right, .left):

            self.imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - ((imageView?.frame.width)!+5)), bottom: 5, right: 5)

            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: (imageView?.frame.width)!)

            self.contentHorizontalAlignment = .left

            self.contentVerticalAlignment = .center

        default :

            print("Please add new case as per your requirment")

        self.layoutIfNeeded()

    }
    }

    func addBorderColor(color: UIColor, cornerRadius: Float) {

        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 1.2
        self.layer.borderColor = color.cgColor
    }

}
