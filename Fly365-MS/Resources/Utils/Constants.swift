//
//  Constants.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

enum ProjectMode {
    case development
    case stagging
}

class Configurations: NSObject {
    static var mode: ProjectMode = .stagging
    
    static let MAX_NUMBER_OF_PASSANGERS = 9
    static let MAX_NUMBER_OF_LEGS = 5
    static let MAX_INFANT_PER_ADULT = 1
    static let MAX_CHILD_PER_ADULT = 6
    
    static var languageCode = "en"
    static let delegate = UIApplication.shared.delegate as! AppDelegate
    //static var loggedIn = Defaults.isLoggedIn
    static var language: String {
        switch languageCode {
        case "en" : return "English"
        case "ar" : return "Arabic"
        default:
            return "English"
        }
    }
    
    
}

class Constants: NSObject {
    
    static let CELL_REUSE_ID = "cell_ID"
    static var BASE_URL: String {
        get{
            if Configurations.mode == .development {
                return "https://api.fly365stage.com/flight"
            } else {
                return "https://api.fly365.com/flight"
            }
        }
    }

}
