//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//
import UIKit

extension UIFont {

    /// Extensions
    public class func printFontFamily(_ font: String) {
        let arr = UIFont.fontNames(forFamilyName: font)
        for name in arr {
            print(name)
        }
    }

    class func font(family: String, type: String, size: Float) -> UIFont {

        let fontName = family + "-" + type
        if let font = UIFont(name: fontName, size: pointsToPixels(size)) {

            return font
        }

        return UIFont.systemFont(ofSize: CGFloat(size))
    }

    private class func pointsToPixels (_ points: Float) -> CGFloat {

        let screenWidth: Float = Float(UIScreen.main.bounds.size.width)
        let screenHeight: Float = Float(UIScreen.main.bounds.size.height)

        let screenMinLength = min(screenWidth, screenHeight)

        let baseWidth: Float = 375
        let screenMinWidth: Float = screenMinLength
        let screenDimention: CGFloat = CGFloat((points * screenMinWidth) / baseWidth)
        return screenDimention
    }

}
