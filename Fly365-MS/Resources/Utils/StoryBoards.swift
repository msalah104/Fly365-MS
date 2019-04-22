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
            return UIStoryboard(name: name, bundle: nil)
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
    
    struct Search {
        static let name = "Search"
        static var storyboard: UIStoryboard {
            return UIStoryboard(name: name, bundle: nil)
        }
        
        // Views
        struct ViewIds {
            static let searchResults = "SearchResultsViewController"
        }
        
        // Segues
        struct Segues {
            static let filter = "filter_view"
            static let stopps = "Stopps"
            static let airlines = "Airlines"
            static let airports = "Airports"
            
        }
    }
}
