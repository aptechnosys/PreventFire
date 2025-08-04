//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
import Foundation
extension String {

    func localized() -> String {
//        let lang = UserDefaultUtils.retriveObjectForKey(LANGUAGE_PREFERNECE) as! String
        _ = "en"
        let langCode = "en"
        let path = Bundle.main.path(forResource: langCode, ofType: "lproj")
        if path == nil {
            return self
        }
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }

    func isNumber() -> Bool {

        let formatter = NumberFormatter()

        if formatter.number(from: self) != nil {

            return true
        }

        return false
    }
    
    // Checks if String contains Email
    public var isEmail: Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-z][a-z|0-9|]*([_][a-z|0-9]+)*([.][a-z|0-9]+([_][a-z|0-9]+)*)?@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex!.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        
    }
    // Character count
    public var length: Int {
        return self.count
    }
    
    func isBlank() -> Bool {
        let text = self
        let trimmed = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
        return ceil(boundingBox.width)
    }

    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func excludeNewLine() -> String {
        return self.replacingOccurrences(of: "\n", with: " ")
    }

    func substring(from: Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func setUnderline() -> NSMutableAttributedString {
        let textRange = NSRange(location: 0, length: self.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        return attributedText
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.2f", self)
    }
}
