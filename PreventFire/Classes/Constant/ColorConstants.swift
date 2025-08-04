//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//
import UIKit

struct AppColor {
    
    static let themeColor = "79,22,111,1.0"
    static let primaryColor =  UIColor.getUIColor(themeColor)
    static let secondaryColor =  UIColor.white
    
    struct Login {
        static let buttonBackgroundColor  = UIColor.getUIColor("255, 192, 0, 1.0") //"#4f166f"
    }
    
    struct Table {
        static let selectedColor  = UIColor(hexString: "#ffc000", alpha: 1.0)
        static let backgroundColor = UIColor.white
    }
    
    struct SupportingColor {
        static let red  = UIColor.getUIColor("180,31,65,1.0")
        static let white  = UIColor.white
        static let orange  = UIColor.getUIColor("192,120,59,1.0")
        static let green  = UIColor.getUIColor("42,150,59,1.0")
    }
    
    struct Tabbar {
        static let normalTextColor = UIColor.getUIColor("82,82,82,1.0")
        static let selectedTextColor = primaryColor
    }
    
    struct NavigationBar {
        static let backgroundColor = primaryColor
        static let textColor = UIColor.white
    }
    
    struct TextField {
        static let placeholderColor = UIColor.getUIColor("203,203,203,1.0")
        static let textColor = UIColor.getUIColor("40,40,40,1.0")
    }
    
    struct TextView {
        static let placeholderColor = UIColor.white
        static let textColor = UIColor.white
    }
    
    
    struct Button {
        static let submitBackgroundColor = UIColor(hexString: "#ffc000", alpha: 1.0)
        static let textColor = UIColor.white
        static let affectedBackgroundColor = UIColor(hexString: "#00aeff", alpha: 1.0)

        
    }
    
    struct Label {
        static let textColor = UIColor.getUIColor("40,40,40,1.0")
        static let extralight = UIColor.getUIColor("155,155,155,1.0")
        static let background = UIColor.white
        static let affectPersonBackground = UIColor(hexString: "#ffc000", alpha: 1.0)
        static let logoTitle = UIColor.getUIColor("247,181,10,1.0")

    }
    
    struct SegmentBar {
        static let selectedTitle = UIColor.white
        static let unSelectedTitle = UIColor.white
    }
    
    struct Category {
        static var theme = primaryColor
    }
    
    struct PageControl {
        static var active = primaryColor
        static var inactive = UIColor.getUIColor("155,155,155,1.0")
    }
}
