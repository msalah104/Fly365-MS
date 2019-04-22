//
//  TripViewModelTest.swift
//  Fly365-MSTests
//
//  Created by Mohammed Salah on 4/22/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import XCTest


@testable import Fly365_MS


class TripViewModelTest: XCTestCase {
    
    // Constants
    let TRIP_FORM_TYPE = TripFormType.RoundTrip
    let ADULTS = 5
    let CHILD = 5
    let INFANT = 5
    let FLIGHT_CLASS = FlightClass.Business
    let INIT_ADULTS = 1
    let INIT_CHILD = 0
    let INIT_INFANT = 0
    let INIT_FLIGHT_CLASS = FlightClass.Economy
    
    private var viewModel:TripViewModel!
    
    override func setUp() {
        viewModel = TripViewModel.init(tripFormType: TRIP_FORM_TYPE)
    }
    
    func testTripFormType () {
        // Assert
        XCTAssertEqual(viewModel.tripType, TRIP_FORM_TYPE)
    }
    
    func testAdultValueUpdate () {
        // When
        viewModel.adult = ADULTS
        
        // Then
        XCTAssertEqual(viewModel.adult, viewModel.tripFormRequest.adult)
    }
    
    func testChildValueUpdate () {
        // When
        viewModel.child = CHILD
        
        // Then
        XCTAssertEqual(viewModel.child, viewModel.tripFormRequest.child)
    }
    
    func testInfantValueUpdate () {
        // When
        viewModel.infant = INFANT
        
        // Then
        XCTAssertEqual(viewModel.infant, viewModel.tripFormRequest.infant)
    }
    
    func testFlightClassValueUpdate () {
        // When
        viewModel.flightClass = FLIGHT_CLASS
        
        // Then
        XCTAssertEqual(viewModel.flightClass, viewModel.tripFormRequest.flightClass)
    }
    
    func testAddNewStep() {
        // Given
        let currentNumberOfLegs = viewModel.tripFormRequest.steps.count
        
        //When
        viewModel.addNewStep()
        
        //Then
        XCTAssertEqual(viewModel.tripFormRequest.steps.count, currentNumberOfLegs + 1)
    }
    
    func testGetTripInfo() {
        
        // When
        let tripInfo = viewModel.getTripInfoViewModel()
        
        // Then
        XCTAssertNotNil(tripInfo)
        XCTAssertEqual(tripInfo.adult, INIT_ADULTS)
        XCTAssertEqual(tripInfo.child, INIT_CHILD)
        XCTAssertEqual(tripInfo.infant, INIT_INFANT)
        XCTAssertEqual(tripInfo.flightClass, INIT_FLIGHT_CLASS)
    }
    
    func testUpdateTripOutOfIndex() {
        //Given
        viewModel.addNewStep()
        let date = Date()
        
        // When
        viewModel.updateTrip(Index: 0, From: nil, To: nil, Date: Date())
        
        // Then
        XCTAssertEqual(viewModel.tripFormRequest.steps.first!.date, date)
        
    }
    
    
    override func tearDown() {
    }
    
    
}
