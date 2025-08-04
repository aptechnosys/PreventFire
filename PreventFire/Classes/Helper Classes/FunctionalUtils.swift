//
//  FunctionalUtils.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 9/17/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit

class FunctionalUtils: NSObject {
    
    class func isValidContactNumber(_ string: String) -> Bool {
        let characterSet  = CharacterSet(charactersIn: "+0123456789").inverted
        var filtered: NSString!
        let inputString: [String] = string.components(separatedBy: characterSet)
        let stringArray: NSArray = NSArray.init(array: inputString)
        filtered = stringArray.componentsJoined(by: "") as NSString?
        return  string == filtered as String
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    class func isValidPassword(_ password: String) -> Bool {
        // Below mentioned RE satisfies and checks
        /* Password Validation Type - 1
         1 - Password length is 8.
         2 - One Alphabet in Password.
         3 - One Special Character in Password. */
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    class func localToGMT(date: String, format: String, timeZone: String) -> Date? {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = format
        dfmatter.timeZone = TimeZone.current
        let zonedate = dfmatter.date(from: date)
        return zonedate ?? Date()
    }
    
    class func dateFromTimeStamp(timeStamp: Int, format: String, timeZone: String) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp) / 1000)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.timeZone = TimeZone.current
        dayTimePeriodFormatter.dateFormat = format
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
   class func timeStringFromUnixTime(unixTime: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixTime))
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date as Date)
    }
    
   class func currentTimeInMiliseconds() -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    class func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter
    }
    
   class func getDateStringFromTimestamp(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = getDateFormatter()
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    class func getTimeInHHMM(dateAsString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"
        
        let date24 = dateFormatter.string(from: date!)
        return date24
    }
    
    class func getTimeInDateHHMM(dateAsString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = NSLocale.current
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.date(from: dateAsString)
        return date!
    }
    
    class func stringFromTimeInterval(interval: Int) -> String {
        let timeInterval = interval
       // let seconds: Int = timeInterval/1000 % 60
        let selectedMinutes = timeInterval/1000/60%60
        let hours = timeInterval/1000/60/60
        return String(format: "%i:%02i", hours, selectedMinutes)
    }
    
    class func timeFromTimeInterval(interval: Int) -> (Int, Int) {
        let timeInterval = interval
       // let seconds: Int = timeInterval/1000 % 60
        let selectedMinutes = timeInterval/1000/60%60
        let hours = timeInterval/1000/60/60
        return (hours, selectedMinutes)
    }
    
    class func stringFromHours(interval: Int) -> Int {
        let timeInterval = interval
        let seconds: Int = timeInterval / 1000
        let hours = (seconds / 3600)
        return hours
    }
    
    class func getTimeIn12HourFrom24Hour(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "H:mm"
            if let inDate = dateFormatter.date(from: time) {
                dateFormatter.dateFormat = "h:mm a"
                let outTime = dateFormatter.string(from: inDate)
                return outTime
        }
        return ""
    }
}
