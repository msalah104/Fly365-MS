//
//  SearchViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/20/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit


class SearchViewModel: NSObject {
    
    var didUpdateResults: (() -> Void)?
    
    var tripRequestForm:TripFormRequest!
    var airportsList:[Airport] = []
    // Original list of search results
    var allFlightList:[Flight] = []
    
    var filterViewModel:FilterViewModel = FilterViewModel()
    
    var flightsList:[Flight] = [] {
        didSet {
            didUpdateResults?()
        }
    }
    
    
    init(tripRequest:TripFormRequest) {
        super.init()
        self.tripRequestForm = tripRequest
        filterViewModel.didUpdateFilterResults = filterResultUpdated
    }
    
    func submitSearch() {
        
        let searchApi = SearchApi(requestParams:tripRequestForm)
        
        searchApi.searchForFlights().then(execute: { (flights) -> Void in
            self.mapResponseToFligh(tripResponse: flights)
            print(flights)
            //            fulfil(items)
        }).catch { (error) in
            print(error)
            self.flightsList = [Flight]()
            //            reject(error)
        }
    }
    
    func mapResponseToFligh(tripResponse:FlightSearchResponse) {
        
        // create Map of legs from legs array
        var legsMap:[String:Leg] = tripResponse.legs!.reduce(into: [String:Leg]()) {
            $0[$1.legId] = $1
        }
        
        var segmetsMap:[String:Segment] = tripResponse.segments!.reduce(into: [String:Segment]()) {
            $0[$1.segmentId] = $1
        }
        
        let setOfStopps = NSMutableSet()
        let setOfAirlines = NSMutableSet()
    
        // assign each leg to it's flight
        var list = [Flight]()
        for flight in tripResponse.itineraries! {
            flight.flightLegs = flight.legs.map({ (legID) -> Leg in
                let leg = legsMap[legID]!
                
                // assign each segment to it's leg
                leg.legSegment = leg.segments.map({ (segmatID) -> Segment in
                    return segmetsMap[segmatID]!
                })
                return leg
            })
            setOfStopps.add(flight.totalStops)
            setOfAirlines.add(flight.carrier?.code)
            list.append(flight)
        }
        airportsList = tripResponse.airports ?? []
        allFlightList = list
        filterViewModel.allFlightList = list
        flightsList = list
        
        // set Filter paramters
        filterViewModel.stoppsList = Array(setOfStopps) as! [Int]
        filterViewModel.AirLines = Array(setOfAirlines) as! [String]
        filterViewModel.airportsList = airportsList.map({$0.code})
    }
    
    func filterResultUpdated () {
        flightsList = filterViewModel.filteredFlightList
    }
    
    // testing
//    func fakeFilter () {
////        filterViewModel.selectedListOfAirlines = ["MS"]
//        filterViewModel.selectedListOfAirports = ["TUN"]
//        filterViewModel.applyFilter()
//    }
    
}


