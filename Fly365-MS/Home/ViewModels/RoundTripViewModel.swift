//
//  RoundTripViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class RoundTripViewModel: TripViewModel {
    
    var originAirport:Airport?{
        get {
            return tripFormRequest.steps[0].origin
        }
        set{
            updateTrip(Index: 0, From: newValue!, To: nil, Date: nil)
            
            // Destination will be Origin for the return trip
            updateTrip(Index: 1, From: nil, To: newValue!, Date: nil)
            didUpdateValue?()
        }
    }
    
    var destinationAirport:Airport?{
        get {
            return tripFormRequest.steps[0].destination
        }
        set{
            updateTrip(Index: 0, From: nil , To: newValue!, Date: nil)
            
            // Destination will be Origin for the return trip
            updateTrip(Index: 1, From: newValue!, To: nil, Date: nil)
            didUpdateValue?()
        }
    }
    
    var departureDate:Date?{
        get {
            return tripFormRequest.steps[0].date
        }
        set{
            updateTrip(Index: 0, From: nil, To: nil, Date: newValue!)
            didUpdateValue?()
        }
    }
    
    var returnDate:Date?{
        get {
            return tripFormRequest.steps[1].date
        }
        set{
            updateTrip(Index: 1, From: nil, To: nil, Date: newValue!)
            didUpdateValue?()
        }
    }
    
    func switchFromAndTo(){
        var temp = originAirport
        originAirport = destinationAirport
        destinationAirport = temp
        temp = nil
    }
    
    init() {
        super.init(tripFormType: .RoundTrip)
        // This will be the return trip, as it's round trip
        self.addNewStep()
        departureDate = Date()
        returnDate = Date()
    }
    
    
    override init(tripFormType: TripFormType) {
        super.init(tripFormType: tripFormType)
        // This will be the return trip, as it's round trip
        self.addNewStep()
        departureDate = Date()
        returnDate = Date()
    }
    
    func notApplicableAirport(airportType:AirportType) -> String {
        
        if airportType == .Origin && destinationAirport != nil{
            return (destinationAirport?.code)!
        } else if airportType == .Destination && originAirport != nil {
            return (originAirport?.code)!
        }
        
        return ""
    }
    
     func isValidSearch() -> String {
        
        if originAirport == nil {
            return FlyErrorMessages.ORIGIN_AIRPORT_SELECTION
        } else if destinationAirport == nil {
            return FlyErrorMessages.DESTINATION_AIRPORT_SELECTION
        } else if departureDate == nil {
            return FlyErrorMessages.DEPARTURE_DATE_SELECTION
        } else if returnDate == nil {
            return FlyErrorMessages.RETURN_DATE_SELECTION
        }
        return ""
    }


}
