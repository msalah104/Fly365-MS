//
//  TripFormRequest.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class TripFormRequest: NSObject {

    var steps:[Step] = [Step]()
    var flightClass:FlightClass?
    var adult = 1
    var infant = 0
    var child = 0
    
    override init() {
        steps.append(Step())
    }
    
}
