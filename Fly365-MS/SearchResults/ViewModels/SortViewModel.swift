//
//  SortViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

enum SearchResultsSortType:String {
    
    case Cheapest = "Cheapest"
    case Quickest = "Quickest"
    case Earliest = "Earliest"
    
    static func index(of aStatus: SearchResultsSortType) -> Int {
        let elements = SearchResultsSortType.elements()
        
        return elements.index(of: aStatus)!
    }
    
    static func element(at index: Int) -> SearchResultsSortType? {
        let elements = SearchResultsSortType.elements()
        
        if index >= 0 && index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
    
    static func elements() -> [SearchResultsSortType] {
        return [SearchResultsSortType.Cheapest, SearchResultsSortType.Quickest, SearchResultsSortType.Earliest]
    }
}

class SortViewModel: NSObject {

}
