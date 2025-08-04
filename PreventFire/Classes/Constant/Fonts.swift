//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit

enum FontType: String {

    case none = ""
    case openSans = "OpenSans"
    case semiBold = "SemiBold"
    case bold = "Bold"
    case regular = "Regular"
    case medium = "Medium"
    case light = "Light"
    case italic = "Italic"

}

enum FontFamily: String {
    case openSans = "OpenSans"
    case poppins = "Poppins"
    case lato = "Lato"
}

enum FontSize: Float {
    case pt7 = 7.0
    case pt8 = 8.0
     case pt9 = 9.0
    case pt10 = 10.0
    case pt11 = 11.0
    case pt12 = 12.0
    case pt13 = 13.0
    case pt14 = 14.0
    case pt15 = 15.0
    case pt16 = 16.0
    case pt17 = 17.0
    case pt18 = 18.0
    case pt19 = 19.0
    case pt20 = 20.0
    case pt21 = 21.0
    case pt22 = 22.0
    case pt23 = 23.0
    case pt24 = 24.0
}

struct FontStyle {
    let family: FontFamily
    let type: FontType
    let size: FontSize
}

extension UIFont {

    static func openSans(font: FontType, size: FontSize) -> UIFont {

        return UIFont.font(family: FontFamily.openSans.rawValue, type: font.rawValue, size: size.rawValue)
    }
    static func poppins(font: FontType, size: FontSize) -> UIFont {
        return UIFont.font(family: FontFamily.poppins.rawValue, type: font.rawValue, size: size.rawValue)
    }
    static func lato(font: FontType, size: FontSize) -> UIFont {
        return UIFont.font(family: FontFamily.lato.rawValue, type: font.rawValue, size: size.rawValue)
    }
}
