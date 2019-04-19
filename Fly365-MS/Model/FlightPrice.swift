//
//  FlightPrice.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class FlightPrice: Codable {

    var base = 0.0
    var tax = 0.0
    var total = 0.0
    var currencyCode = ""
    var perPassenger:PassangerCost?
    
}
