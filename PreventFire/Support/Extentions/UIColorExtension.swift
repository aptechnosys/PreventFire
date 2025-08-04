import UIKit

extension UIColor {
    // init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
    public convenience init(rgb: String, alpha: CGFloat) {
        let rgbArray = rgb.components(separatedBy: ",")
        var redValue: CGFloat = 255.0
        var greenValue: CGFloat = 255.0
        var blueValue: CGFloat = 255.0
        func getCGFloat(string: String) -> CGFloat? {
            if let num = NumberFormatter().number(from: string) {
                return CGFloat(num.floatValue)
            } else {
                return 0.5
            }
        }
        if rgbArray.count == 3 {
            redValue = getCGFloat(string: rgbArray[0])!
            greenValue = getCGFloat(string: rgbArray[1])!
            blueValue = getCGFloat(string: rgbArray[2])!
        }
        self.init(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alpha)
    }
    // init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
    public convenience init(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alphaValue: CGFloat) {
        self.init(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alphaValue)
    }
    // init method with hex string and alpha(default: 1)
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
          let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
          let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
          let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
          self.init(red: red, green: green, blue: blue, alpha: alpha)        } else {
            return nil
        }
    }
    // init method from Gray value and alpha(default:1)
    public convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(red: gray/255, green: gray/255, blue: gray/255, alpha: alpha)
    }
    // Red component of UIColor (get-only)
    public var redComponent: Int {
        var redComponentValue: CGFloat = 0
        getRed(&redComponentValue, green: nil, blue: nil, alpha: nil)
        return Int(redComponentValue * 255)
    }
    // Green component of UIColor (get-only)
    public var greenComponent: Int {
        var greenComponentVlaue: CGFloat = 0
        getRed(nil, green: &greenComponentVlaue, blue: nil, alpha: nil)
        return Int(greenComponentVlaue * 255)
    }
    // blue component of UIColor (get-only)
    public var blueComponent: Int {
        var blueComponentValue: CGFloat = 0
        getRed(nil, green: nil, blue: &blueComponentValue, alpha: nil)
        return Int(blueComponentValue * 255)
    }
    // Alpha of UIColor (get-only)
    public var alpha: Int {
        var alphaValue: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &alphaValue)
        return Int(alphaValue)
    }
    // Returns random UIColor with random alpha(default: false)
    public static func randomColor(_ randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    class func colorFromHexColor(_ hexString: String) -> UIColor {
        let hexString: NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let redValue = Int(color >> 16) & mask
        let gedValue = Int(color >> 8) & mask
        let blueValue = Int(color) & mask
        let red   = CGFloat(redValue) / 255.0
        let green = CGFloat(gedValue) / 255.0
        let blue  = CGFloat(blueValue) / 255.0
        return self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    class func colorForRGBColor(_ rgbColor: String, alpha: CGFloat = 1.0) -> UIColor? {
        let rgbArray: [String] = rgbColor.components(separatedBy: ",")
        guard let redColor = Int(rgbArray[0]) else {
            return nil
        }
        guard let greenColor = Int(rgbArray[1]) else {
            return nil
        }
        guard let blueColor = Int(rgbArray[2]) else {
            return nil
        }
        return self.init(red: CGFloat(redColor/255), green: CGFloat(greenColor/255), blue: CGFloat(blueColor/255), alpha: alpha)
    }
    
    enum HexFormat {
        case RGB
        case ARGB
        case RGBA
        case RRGGBB
        case AARRGGBB
        case RRGGBBAA
    }
    
    enum HexDigits {
        case d3Digit, d4Digit, d6Digit, d8Digit
    }
    
    func hexString(_ format: HexFormat = .RRGGBBAA) -> String {
        let maxi = [.RGB, .ARGB, .RGBA].contains(format) ? 16 : 256
        
        func toI(_ colorValue: CGFloat) -> Int {
            return min(maxi - 1, Int(CGFloat(maxi) * colorValue))
        }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let redi = toI(red)
        let greeni = toI(green)
        let bluei = toI(blue)
        let alphai = toI(alpha)
        
        switch format {
        case .RGB:       return String(format: "#%X%X%X", redi, greeni, bluei)
        case .ARGB:      return String(format: "#%X%X%X%X", alphai, redi, greeni, bluei)
        case .RGBA:      return String(format: "#%X%X%X%X", redi, greeni, bluei, alphai)
        case .RRGGBB:    return String(format: "#%02X%02X%02X", redi, greeni, bluei)
        case .AARRGGBB:  return String(format: "#%02X%02X%02X%02X", alphai, redi, greeni, bluei)
        case .RRGGBBAA:  return String(format: "#%02X%02X%02X%02X", redi, greeni, bluei, alphai)
        }
    }
    
    func hexString(_ digits: HexDigits) -> String {
        switch digits {
        case .d3Digit: return hexString(.RGB)
        case .d4Digit: return hexString(.RGBA)
        case .d6Digit: return hexString(.RRGGBB)
        case .d8Digit: return hexString(.RRGGBBAA)
        }
    }
}

private extension CGFloat {
    /// SwiftRandom extension
    static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}
