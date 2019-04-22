//
//  TripViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

protocol TripDataSource {
    func getTripInfoViewModel() -> TripInfoViewModel
    func getNAAirport(airportType:AirportType ) -> String
}

class TripViewController: BaseViewController {

    var dataSource:TripDataSource?
    
    @IBOutlet weak var pickerViewContainer: UIView!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var btnOrigin:RoundedCornersButton!
    @IBOutlet weak var btnDeparture:RoundedCornersButton!
    @IBOutlet weak var btnDestination:RoundedCornersButton!
    @IBOutlet weak var btnSwitch:RoundedCornersButton!
    @IBOutlet weak var btnPassangers:RoundedCornersButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let picker = datePicker {
        
            picker.minimumDate = Date()
            pickerViewContainer.isHidden = true
        }
    }
    
    
    
    @IBAction func didPressDone(_ sender: UIBarButtonItem) {
         pickerViewContainer.isHidden = true
    }
    
    func switchTripFromAndTo(Index index:Int = 0){
        
    }
    
    func getAirportView(airportType:AirportType, tripIndex:Int = 0) -> AirportSelectionViewController {
        let airportsVC = StoryBoards.Home.storyboard.instantiateViewController(withIdentifier: StoryBoards.Home.ViewIds.airports) as! AirportSelectionViewController
        airportsVC.naAirportID = (dataSource?.getNAAirport(airportType: airportType))!
        return airportsVC
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoards.Home.Segues.SELECT_PASSANGER {
            let tripInfoVC = segue.destination as! TripInfoViewController
            tripInfoVC.delegate = self as? TripInfoDelegate
            tripInfoVC.viewModel = dataSource?.getTripInfoViewModel()
        }
    }
    
    // MARK: - IBActions
    @IBAction func didPressPassangers(_ button:UIButton) {
        performSegue(withIdentifier: StoryBoards.Home.Segues.SELECT_PASSANGER, sender: nil)
    }
    
    @IBAction func didPressOrigin(_ button:UIButton) {
        let airportsVC = getAirportView(airportType: .Origin)
        airportsVC.airportType = .Origin
        airportsVC.delegate = self as? AirpotSelectionDelegate
        self.present(airportsVC, animated: true, completion: nil)
    }
    
    @IBAction func didPressDestination(_ button:UIButton) {
        let airportsVC = getAirportView(airportType: .Destination)
        airportsVC.airportType = .Destination
        airportsVC.delegate = self as? AirpotSelectionDelegate
        self.present(airportsVC, animated: true, completion: nil)
    }
    
    @IBAction func didPressSwitch(_ button:UIButton) {
        switchTripFromAndTo()
    }
    
    @IBAction func didPressDeparture(_ button:UIButton) {
        pickerViewContainer.isHidden = false
    }
    
    @IBAction func didPressSearch(_ button:UIButton) {
        
    }
}




