//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

extension UITextField {

    func placeholderColor(text: String?, color: UIColor, fontFamily: String, font: String, size: Float) {

        let text = text ?? ""

        let fontSize = pointsToPixels(size)

        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.font(family: fontFamily, type: font, size: Float(fontSize))])

    }

    func addRightImage(name: String?) {

        let name = name ?? ""
        self.rightViewMode = .always
        let imageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.init(named: name)
        self.rightView = imageView

    }
    
    func addLeftImage(name: String?) {
        
        let name = name ?? ""
        let imageSize: CGFloat = 24
        let padding: CGFloat = 8
        let containerWidth = imageSize + padding * 2
        let containerHeight = self.frame.height
        
        // Create the image view
        let image = UIImage(named: name) // replace with your image name
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
        
        // Set the image view as the left view of the text field
        self.leftView = imageView
        self.leftViewMode = .always
        
        // Optional: Add padding between image and text
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        imageView.center = paddingView.center
        paddingView.addSubview(imageView)
                
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: paddingView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor, constant: padding),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
    private func pointsToPixels (_ points: Float) -> CGFloat {

        let screenWidth: Float = Float(UIScreen.main.bounds.size.width)
        let screenHeight: Float = Float(UIScreen.main.bounds.size.height)

        let screenMinLength = min(screenWidth, screenHeight)

        let baseWidth: Float = 375
        let screenMinWidth: Float = screenMinLength

        let screenDimention: CGFloat = CGFloat((points * screenMinWidth) / baseWidth)
        return screenDimention
    }

    func configureDarkThemeTextField(text: String, delegate: AnyObject) {

        self.backgroundColor = AppColor.primaryColor
        
        self.placeholderColor(text: text.localized(),
                                      color: AppColor.TextField.placeholderColor,
                                      fontFamily: FontFamily.poppins.rawValue,
                                      font: FontType.regular.rawValue,
                                      size: FontSize.pt16.rawValue)
        self.font = UIFont.poppins(font: .regular, size: .pt16)

        self.borderStyle = .roundedRect

        self.textAlignment = .left

        self.textColor = .white
        
        self.tintColor = .white
        
        UITextField.appearance().tintColor = UIColor.white
        
        self.delegate = delegate as? UITextFieldDelegate
        
    }
    
    /*
    func configureTextField(text: String,
                            color: UIColor,
                            fontFamily: FontFamily,
                            font: FontType,
                            size: FontSize,
                            delegate: AnyObject) {
        self.placeholderColor(text: text.localized(),
                              color: AppColor.TextField.placeholderColor,
                              fontFamily: font.rawValue,
                              font: font.rawValue,
                              size: size.rawValue)
        self.font = UIFont.font(family: font.rawValue, type: font.rawValue, size: size.rawValue)
        self.textColor = color
        self.textAlignment = .left
        self.borderStyle = .none
        self.tintColor = AppColor.primaryColor
    } */
    
    func configureTextField(text: String,
                            color: UIColor,
                            font: FontStyle,
                            delegate: AnyObject) {
        self.placeholderColor(text: text.localized(),
                              color: .white,
                              fontFamily: font.family.rawValue,
                              font: font.type.rawValue,
                              size: font.size.rawValue)
        self.font = UIFont.font(family: font.family.rawValue, type: font.type.rawValue, size: font.size.rawValue)
        self.textColor = color
        self.textAlignment = .left
        self.borderStyle = .none
        self.tintColor = .white
        self.text = ""
    }
    
    func addBorderColor(color: UIColor, cornerRadius: Float) {
        self.layer.borderColor = color.cgColor

    }

    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func roundCorners(_ cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
