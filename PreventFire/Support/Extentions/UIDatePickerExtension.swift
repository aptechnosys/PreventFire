//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//
import Foundation
import UIKit
extension UIDatePicker {
    
    func setDate(_ date: Date, unit: NSCalendar.Unit, deltaMinimum: Int, deltaMaximum: Int, animated: Bool) {
        setDate(date, animated: animated)
        setMinMax(unit: unit, deltaMinimum: deltaMinimum, deltaMaximum: deltaMaximum)
    }
    
    func setMinMax(unit: NSCalendar.Unit, deltaMinimum: Int, deltaMaximum: Int) {
        if let gregorian = NSCalendar(calendarIdentifier: .gregorian) {
            if let minDate = gregorian.date(byAdding: unit, value: deltaMinimum, to: self.date) {
                minimumDate = minDate
            }
            if let maxDate = gregorian.date(byAdding: unit, value: deltaMaximum, to: self.date) {
                maximumDate = maxDate
            }
        }
    }
    
    func setDate(_ date: Date, unit: NSCalendar.Unit, deltaMinimum: Int, animated: Bool) {
        setDate(date, animated: animated)
        if let gregorian = NSCalendar(calendarIdentifier: .gregorian) {
            if let minDate = gregorian.date(byAdding: unit, value: deltaMinimum, to: self.date) {
                minimumDate = minDate
            }
        }
    }
}
