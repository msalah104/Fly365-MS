//
//  AirportCriteria.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class AirportCriteria: NSObject, Criteria {
    
    var options:[String] = []
    
    func meetCriteria(flights: [Flight]) -> [Flight] {
        var result = [Flight]()
    
        
        
        for flight in flights {
            var flightSegments = flight.flightLegs!.flatMap({$0.legSegment})
            var selectedOpetions = flightSegments.flatMap({$0.filter({options.contains(($0.origin?.code)!)})})
            selectedOpetions.append(contentsOf:flightSegments.flatMap({$0.filter({options.contains(($0.destination?.code)!)})}))
            
            if !selectedOpetions.isEmpty {
                result.append(flight)
            }
        }
        
        return result
    }
    
    required init(options: [Any]) {
        self.options = options as! [String]
    } 
}
