//
//  LanguageLocalisationName.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 10/15/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation

enum LanguageName {
    case english
    case hindi
    
    var code: String {
        
        switch self {
        case .english:  return "en"
        case .hindi: return  "pt-BR"
        }
    }
}

struct Localization {
    static var language: LanguageName = .english
}

extension Localization {
    static func setLanguage(_ language: LanguageName) {
        Localization.language = language
    }
}
