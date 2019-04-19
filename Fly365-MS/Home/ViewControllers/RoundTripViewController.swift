//
//  RoundTripViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

enum DatePickType {
    case Departure
    case Return
}

class RoundTripViewController: TripViewController {
    
    var viewModel:RoundTripViewModel!
    var datePickState:DatePickType!
    
    @IBOutlet weak var btnReturn:RoundedCornersButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupView() {
        viewModel = RoundTripViewModel(tripFormType: .RoundTrip)
        viewModel.didUpdateValue = updateUI
        self.dataSource = self
    }
    
    override func didPressDone(_ sender: UIBarButtonItem) {
        if datePickState == .Departure {
            viewModel.departureDate = datePicker.date
        } else {
            if (viewModel.departureDate?.timeIntervalSince(datePicker.date).sign)! == .minus {
               viewModel.returnDate = datePicker.date
            } else {
                //TODO add error message for selected return date after dep date
                print("Return date must be after departure date")
                return
            }
            
        }
        pickerViewContainer.isHidden = true
    }
    
    
    func updateUI() {
        if let origin = viewModel.originAirport {
            btnOrigin.setTitle("\(origin.cityName) (\(origin.code))", for: .normal)
        }
        
        if let dest = viewModel.destinationAirport {
            btnDestination.setTitle("\(dest.cityName) (\(dest.code))", for: .normal)
        }
        
        if let depart = viewModel.departureDate {
            btnDeparture.setTitle(FlyUtils.homeDateFormate(date: depart), for: .normal)
        }
        
        if let returnD = viewModel.returnDate {
            btnReturn.setTitle(FlyUtils.homeDateFormate(date: returnD), for: .normal)
        }
    }
    
    override func didPressDeparture(_ button: UIButton) {
        pickerViewContainer.isHidden = false
        datePickState = .Departure
    }
    
    @IBAction func didPressReturn(_ button:UIButton) {
        pickerViewContainer.isHidden = false
        datePickState = .Return
    }
    
    override func switchTripFromAndTo(Index index: Int) {
        if viewModel.originAirport != nil && viewModel.destinationAirport != nil {
            viewModel.switchFromAndTo()
        }
    }
    
    override func didPressSearch(_ button: UIButton) {
        let errorMessage = viewModel.isValidSearch()
        if  errorMessage.isEmpty {
            //TODO show error message
            return
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RoundTripViewController:AirpotSelectionDelegate {
    
    func userDidSelectAirport(airport: Airport, OfType type: AirportType) {
        if type == .Origin {
            self.viewModel.originAirport = airport
        } else {
            self.viewModel.destinationAirport = airport
        }
        
    }
    
}

extension RoundTripViewController: TripInfoDelegate {
    func tripInfoChanged(_ adults: Int, _ child: Int, _ infant: Int, _ flightClass: FlightClass) {
        self.viewModel.adult = adults
        self.viewModel.child = child
        self.viewModel.infant = infant
        self.viewModel.flightClass = flightClass
        
        let count = adults + infant + child
        
        self.btnPassangers.setTitle("\(count) Passanger, \(flightClass.rawValue)", for: .normal)
    }
}

extension RoundTripViewController: TripDataSource {
    func getTripInfoViewModel() -> TripInfoViewModel {
        return viewModel.getTripInfoViewModel()
    }
    
    
    func getNAAirport(airportType: AirportType) -> String {
        return viewModel.notApplicableAirport(airportType: airportType)
    }
    
    
}
