//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }

    func configureLabel(title: String, color: UIColor, font: FontType, size: FontSize, alignment: NSTextAlignment) {

        self.text = title.localized()
        self.font = UIFont.poppins(font: font, size: size)
        self.textAlignment = alignment
        self.textColor = color
        self.backgroundColor = UIColor.clear
    }
  
    func configureLabel(title: String, color: UIColor, font: FontStyle, alignment: NSTextAlignment) {
        self.text = title.localized()
        self.font = UIFont.font(family: font.family.rawValue, type: font.type.rawValue, size: font.size.rawValue)
        self.textAlignment = alignment
        self.textColor = color
        self.backgroundColor = UIColor.clear
    }
    
    func configureLabel(color: UIColor, font: FontStyle, alignment: NSTextAlignment) {
        
        self.font = UIFont.font(family: font.family.rawValue, type: font.type.rawValue, size: font.size.rawValue)
        self.textAlignment = alignment
        self.textColor = color
        self.backgroundColor = UIColor.clear
    }
    
    func configureThemeView() {
        self.backgroundColor = UIColor.lineSeperatorBackgroundColor
    }
}
