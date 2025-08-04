//  Copyright 2016-2017 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); 
//  you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is 
//  distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and limitations under the License.

// MARK: - UITextField extension

import UIKit

class TextFieldRangeValidationModel {
    var textField: UITextField
    var range: NSRange
    var string: String
    var minLimit: Int
    var maxLimit: Int
    var replacingCharacter: String
    
    init(textField: UITextField, range: NSRange, string: String, minLimit: Int, maxLimit: Int, replacingCharacter: String) {
        self.textField = textField
        self.range = range
        self.string = string
        self.minLimit = minLimit
        self.maxLimit = maxLimit
        self.replacingCharacter = replacingCharacter
    }
}

extension UITextField {
    
    func fixCaretPosition() {
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }
    
    func setTextfieldLimit(textFieldModel: TextFieldRangeValidationModel) -> Bool {
        let textField: UITextField = textFieldModel.textField
        let range: NSRange = textFieldModel.range
        let string: String = textFieldModel.string
        let minLimit: Int = textFieldModel.minLimit
        let maxLimit: Int = textFieldModel.maxLimit
        let prefixCharacter: String = textFieldModel.replacingCharacter
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        
        let decimalString = components.joined() as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
        
        if length == 0 || (length > maxLimit && !hasLeadingOne) || length > maxLimit + 1 {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            
            return (newLength > maxLimit) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne {
            formattedString.append("1 ")
            index += 1
        }
        
        if length - index > minLimit {
            let prefix = decimalString.substring(with: NSRange(location: index, length: minLimit) )
            formattedString.appendFormat("%@" + prefixCharacter as NSString, prefix)
            index += minLimit
        }
        
        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        textField.text = formattedString as String
        return false
    }
    
    func setMobileNumberLimit(textFieldModel: TextFieldRangeValidationModel) -> Bool {
        let textField: UITextField = textFieldModel.textField
        let range: NSRange = textFieldModel.range
        let string: String = textFieldModel.string
        let maxLimit: Int = textFieldModel.maxLimit
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        
        let decimalString = components.joined() as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
        
        if length == 0 || (length > maxLimit && !hasLeadingOne) || length > maxLimit + 1 {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            
            return (newLength > maxLimit) ? false : true
        }
        return true
    }
}
