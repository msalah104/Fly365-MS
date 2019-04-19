//
//  Segment.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class Segment: Codable {
    
    var segmentId = ""
    var origin:EndPoint?
    var destination:EndPoint?
    var stops:[Stop] = []
    var fuellingStops:[FuellingStops] = []
    var carrier = ""
    var baggage = ""
    var flightInfo:FlightInfo = FlightInfo()
    var cabinClass = ""
    var stopOvertime = 0
    var seatCount = ""

}
