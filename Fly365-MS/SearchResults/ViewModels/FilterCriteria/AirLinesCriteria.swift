//
//  AirLinesCriteria.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class AirLinesCriteria: NSObject, Criteria {
  
    var options:[String] = []
    
    func meetCriteria(flights: [Flight]) -> [Flight] {
        var result = [Flight]()
        
        for flight in flights {
            if options.contains((flight.carrier?.code)!) {
                result.append(flight)
            }
        }
        
        return result
    }
    
    required init(options: [Any]) {
        self.options = options as! [String]
    }
}
