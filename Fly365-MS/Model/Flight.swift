//
//  Flight.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class Flight: Codable {

    var itineraryId = ""
    var airPriceGroup = 0
    var legs:[String] = []
    var flightLegs:[Leg]?
    var pricing:FlightPrice?
    var displayPricing:FlightPrice?
    var totalStops = 0
    var discounts:[String]?
    var carrier:Carrier?
}
