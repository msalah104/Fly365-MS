//
//  StoryBoards.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class StoryBoards: NSObject {

    
    struct Home {
        static let name = "Home"
        static var storyboard: UIStoryboard {
            return UIStoryboard(name: "Home", bundle: nil)
        }
        
        // Views
        struct ViewIds {
            static let airports = "airportSelection"
        }
        
        // Segues
        struct Segues {
            static let SELECT_PASSANGER = "passanger"
        }
    }
}
