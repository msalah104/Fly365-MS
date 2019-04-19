//
//  Leg.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class Legs: Codable {
    var legs:[Leg] = []
}

class Leg: Codable {
    
    var legId = ""
    var origin = ""
    var destination = ""
    var departureDate = ""
    var arrivalDate = ""
    var stops = 0
    var duration = 0
    var segments:[String] = []
    var legSegmenr:[Segment] = []
    var carrier:Carrier?

}
