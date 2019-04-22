//
//  RoundTripTests.swift
//  Fly365-MSTests
//
//  Created by Mohammed Salah on 4/22/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import XCTest
@testable import Fly365_MS

class RoundTripViewModelTests: XCTestCase {
    
    private var airport:Airport!

    private var viewModel:RoundTripViewModel!
    
    override func setUp() {
        viewModel = RoundTripViewModel.init(tripFormType: .RoundTrip)
        airport = Airport()
        airport.cityCode = "TS"
        airport.cityName = "TEST"
        airport.code = "TS"
    }
    
    // Test if search is valide even if i didn't add any params
    func testIsValidSearchOrigin() {

        // Then
        XCTAssertTrue(!viewModel.isValidSearch().isEmpty)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
