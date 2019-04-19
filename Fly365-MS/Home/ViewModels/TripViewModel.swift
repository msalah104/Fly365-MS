//
//  TripViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

enum TripFormType {
    case OneWay
    case RoundTrip
    case MultiWay
}

protocol TripsUpdateDelegate {
    func updateTrip(Index index:Int,From from:Airport?,To to:Airport?, Date date:Date?)
}

class TripViewModel: NSObject {
    
    var tripFormRequest:TripFormRequest = TripFormRequest()
    var tripType = TripFormType.OneWay
    private var tripInfo:TripInfoViewModel?
    var didUpdateValue: (() -> Void)?
    
    var adult:Int?{
        get {
            return tripFormRequest.adult
        }
        set{
            tripFormRequest.adult = newValue!
            didUpdateValue?()
        }
    }
    
    var child:Int?{
        get {
            return tripFormRequest.child
        }
        set{
            tripFormRequest.child = newValue!
            didUpdateValue?()
        }
    }
    
    var infant:Int?{
        get {
            return tripFormRequest.infant
        }
        set{
            tripFormRequest.infant = newValue!
            didUpdateValue?()
        }
    }
    
    var flightClass:FlightClass?{
        get {
            return tripFormRequest.flightClass
        }
        set{
            tripFormRequest.flightClass = newValue!
            didUpdateValue?()
        }
    }
    
    init(tripFormType:TripFormType) {
        super.init()
        self.tripType = tripFormType
        self.tripInfo = TripInfoViewModel()
    }
    
    func addNewStep() {
        tripFormRequest.steps.append(Step())
    }
    
    private func updateFromAirportForTrip(Index index:Int, Airport airport:Airport) {
        let step = tripFormRequest.steps[index]
        step.origin = airport
    }
    
    private func updateToAirportForTrip(Index index:Int, Airport airport:Airport) {
        let step = tripFormRequest.steps[index]
        step.destination = airport
    }
    
    private func updateDateForTrip(Index index:Int, Date date:Date) {
        let step = tripFormRequest.steps[index]
        step.date = date
    }
    
    func getTripInfoViewModel() -> TripInfoViewModel {
        
        if tripInfo == nil {
            tripInfo = TripInfoViewModel()
        }
        
        tripInfo?.adult = adult ?? 1
        tripInfo?.child = child ?? 0
        tripInfo?.infant = infant ?? 0
        tripInfo?.flightClass = flightClass ?? .Economy
        
        return tripInfo!
    }
    
}

extension TripViewModel: TripsUpdateDelegate {
    func updateTrip(Index index:Int,From from:Airport?,To to:Airport?, Date date:Date?) {
        if let origin = from {
            updateFromAirportForTrip(Index: index, Airport: origin)
        }
        if let destination = to {
            updateToAirportForTrip(Index: index, Airport: destination)
        }
        if let departure = date {
            updateDateForTrip(Index: index, Date: departure)
        }
    }
    
}
