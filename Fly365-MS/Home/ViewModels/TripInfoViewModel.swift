//
//  TripInfoViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

enum FlightClass:String {
    
    case Economy = "Economy"
    case PremiumEconomy = "Premium Economy"
    case Business = "Business"
    case First = "First"
    case PremiumFirst = "Premium First"
    
    static func index(of aStatus: FlightClass) -> Int {
        let elements = FlightClass.elements()
        
        return elements.index(of: aStatus)!
    }
    
    static func element(at index: Int) -> FlightClass? {
        let elements = FlightClass.elements()
        
        if index >= 0 && index < elements.count {
            return elements[index]
        } else {
            return nil
        }
    }
    
    static func elements() -> [FlightClass] {
        return [FlightClass.Economy, FlightClass.PremiumEconomy, FlightClass.Business, FlightClass.First, FlightClass.PremiumFirst]
    }
}

enum PassangerType {
    case Adult
    case Child
    case Infant
}

protocol TripInfoDelegate:class {
    func tripInfoChanged(_ adults:Int,_ child:Int,_ infant:Int,_ flightClass:FlightClass)
}

// To save tripView status for each type of trip (one way, rountrip, multi city)
class TripInfoViewModel: NSObject {

    var didUpdateValue: (() -> Void)?
    
    var adult = 1 {
        didSet {
            didUpdateValue?()
        }
    }
    
    var child = 0 {
        didSet {
            didUpdateValue?()
        }
    }
    
    var infant = 0{
        didSet {
            didUpdateValue?()
        }
    }
    
    var flightClass:FlightClass = .Economy{
        didSet {
            didUpdateValue?()
        }
    }
    
    func getValueOfType(passangerType:PassangerType) -> Int {
        if passangerType == .Adult {
            return adult
        } else if passangerType == .Child {
            return child
        } else {
            return infant
        }
    }
    
    func setValueOfType(passangerType:PassangerType, value:Int)  {
        if passangerType == .Adult {
            adult = value
        } else if passangerType == .Child {
            child = value
        } else {
            infant = value
        }
    }
    
    
    func validateNumberOfPassangers(passangerType:PassangerType, newValue:Int) -> String {
        
        // check passangers count
        if (adult + child + infant) > Configs.MAX_NUMBER_OF_PASSANGERS - 1 {
            return "Max number of passnager is \(Configs.MAX_NUMBER_OF_PASSANGERS )"
        }
        
        // Check number of infant per adult
        if  passangerType == .Child && newValue > Configs.MAX_CHILD_PER_ADULT {
            return "Max number of Childern is \(Configs.MAX_CHILD_PER_ADULT )"
        }
        
        // Check number of infant per adult
        if  passangerType == .Infant && (newValue / adult) > Configs.MAX_INFANT_PER_ADULT {
            return "Max number of infant for 1 adult is \(Configs.MAX_INFANT_PER_ADULT )"
        }
        
        return ""
    }
}
