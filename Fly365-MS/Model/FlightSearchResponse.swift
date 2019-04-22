//
//  FlightSearchResponse.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class FlightSearchResponse: Codable {

    var searchId:String?
    var itineraries:[Flight]?
    var legs:[Leg]?
    var segments:[Segment]?
    var airports:[Airport]?
    
    // Error fields
    var code:String?
    var message:String?
    
    
    
}
