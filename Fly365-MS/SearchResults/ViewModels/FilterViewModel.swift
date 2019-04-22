//
//  FilterViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

protocol FilterManagerDataSource {
    func getStoppsList() -> [Int]
    func getAirlinesList() -> [String]
    func getAirportsList() -> [String]
    func updateSelectedStopps (stopps:[Int])
    func updateSelectedAirlines (airlines:[String])
    func updateSelectedAirports (airports:[String])
    func getSelectedStopps () -> [Int]
    func getSelectedAirlines () -> [String]
    func getSelectedAirports () -> [String]
    func applyFilter()
    func clearFilter()
}


class FilterViewModel: NSObject {
    
    var didUpdateFilterResults: (() -> Void)?
    
    // All selected filters
    var selectedListOfStops:[Int] = []
    var selectedListOfAirlines:[String] = []
    var selectedListOfAirports:[String] = []
    
    // Uniqu values in search results
    var airportsList:[String] = []
    var stoppsList:[Int] = []
    var AirLines:[String] = []
    
    // Original list of search results
    var allFlightList:[Flight] = []
    
    // filtered flight list baesd on selected filters
    var filteredFlightList:[Flight] = [] {
        didSet {
            didUpdateFilterResults?()
        }
    }

}

extension FilterViewModel : FilterManagerDataSource {
    func getStoppsList() -> [Int] {
        return stoppsList
    }
    
    func getAirlinesList() -> [String] {
        return AirLines
    }
    
    func getAirportsList() -> [String] {
        return airportsList
    }
    
    func updateSelectedStopps (stopps:[Int]) {
        selectedListOfStops = stopps
    }
    
    func updateSelectedAirlines (airlines:[String]) {
        selectedListOfAirlines = airlines
    }
    
    func updateSelectedAirports (airports:[String]) {
        selectedListOfAirports = airports
    }
    
    func getSelectedStopps () -> [Int] {
        return selectedListOfStops
    }
    
    func getSelectedAirlines () -> [String] {
        return selectedListOfAirlines
    }
    
    func getSelectedAirports () -> [String] {
        return selectedListOfAirports
    }
    
    func applyFilter() {
        let stopCri = StoppsCriteria(options: selectedListOfStops)
        let airlinesCri = AirLinesCriteria(options: selectedListOfAirlines)
        let airportsCri = AirportCriteria(options: selectedListOfAirports)
        
        var result = allFlightList
        
        if !selectedListOfStops.isEmpty {
            result = stopCri.meetCriteria(flights: result)
        }
        
        if !selectedListOfAirlines.isEmpty {
            result = airlinesCri.meetCriteria(flights: result)
        }
        
        if !selectedListOfAirports.isEmpty {
            result = airportsCri.meetCriteria(flights: result)
        }
        
        filteredFlightList = result
    }
    
    func clearFilter() {
        selectedListOfStops = []
        selectedListOfAirlines = []
        selectedListOfAirports = []
    }
}
