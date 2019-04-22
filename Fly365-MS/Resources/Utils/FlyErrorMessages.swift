//
//  FlyErrorMessages.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class FlyErrorMessages: NSObject {
    static let ORIGIN_AIRPORT_SELECTION = "Please select origin airport"
    static let DESTINATION_AIRPORT_SELECTION = "Please select destination airport"
    static let DEPARTURE_DATE_SELECTION = "Please select departure date"
    static let RETURN_DATE_SELECTION = "Please select return date"
    static let NO_Internat_Connection_Message = "No Internet Connection"
    static let SAME_AIRPORT_Message = "Destenation must be diffrent from origin"
    static let REUTRN_BEFORE_DEPARTURE_Message = "Return date must be after departure date"
    static let MAX_N_PASSANGERS_Message = "Max number of passnager is \(Configurations.MAX_NUMBER_OF_PASSANGERS )"
    static let MAX_N_CHILD_Message = "Max number of Childern is \(Configurations.MAX_CHILD_PER_ADULT )"
    static let MAX_N_INFANT_Message = "Max number of infant for 1 adult is \(Configurations.MAX_INFANT_PER_ADULT )"
}
