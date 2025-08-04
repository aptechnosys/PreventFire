import Foundation
import UIKit

enum MenuOptions {
    case dashboard
    case fireSafetyConcerns
    case previousConcerns
    case raiseYourVoiceForFire
    case alerts
    case profile
    case languageSetting
    case signout
    
    static let all: [MenuOptions] = [.dashboard, .fireSafetyConcerns,.previousConcerns, .raiseYourVoiceForFire, .alerts, .profile, .languageSetting, .signout]
    
    var title: (String) {
        switch self {
            
        case .dashboard:
            return LocalizedStrings.dashboard
        case .fireSafetyConcerns:
            return LocalizedStrings.fireSafetyConcerns
        case .previousConcerns:
            return LocalizedStrings.previousConcerns
        case .raiseYourVoiceForFire:
            return LocalizedStrings.raiseYourVoiceForFire
        case .alerts:
            return LocalizedStrings.alerts
        case .profile:
            return LocalizedStrings.profile
        case .languageSetting:
            return LocalizedStrings.languageSetting
        case .signout:
            return LocalizedStrings.signout
        }
    }
    
    var icon: (UIImage) {
        switch self {
            
        case .dashboard:
            return #imageLiteral(resourceName: "icon_dashboard")
        case .fireSafetyConcerns:
            return #imageLiteral(resourceName: "menu_left")
        case .previousConcerns:
            return #imageLiteral(resourceName: "icon_previous")
        case .raiseYourVoiceForFire:
            return #imageLiteral(resourceName: "icon_raise_your_voice")
        case .alerts:
            return #imageLiteral(resourceName: "icon_alerts")
        case .profile:
            return #imageLiteral(resourceName: "icon_profile")
        case .languageSetting:
            return #imageLiteral(resourceName: "icon_language_setting")
        case .signout:
            return #imageLiteral(resourceName: "icon_sign_out")
        }
    }
    
}
