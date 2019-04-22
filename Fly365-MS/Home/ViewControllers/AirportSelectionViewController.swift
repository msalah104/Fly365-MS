//
//  AirportSelectionViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit


enum AirportType:String{
    case Origin = "Where From ?"
    case Destination = "Where To ?"
}


protocol AirpotSelectionDelegate:class {
    func userDidSelectAirport(airport: Airport, OfType type:AirportType)
}

class AirportSelectionViewController: BaseViewController {
    
    var naAirportID = ""
    var airportType:AirportType = .Origin
    var viewModel:AirportsViewModel?
    var fetchedAirports = [Airport]()
    
    weak var delegate:AirpotSelectionDelegate!
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tblAirports: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AirportsViewModel()
    }
    
    override func setupView() {
        // Hide the footer part of the table view to avoid showing empty cells
        tblAirports.tableFooterView = UIView.init(frame: CGRect.zero)
        tfSearch.placeholder = airportType.rawValue
    }

    
    func updateAirportsWithText(_ text:String) {
        
        // Fetch airports based on the user input (static for now)
        // TODO: Integrate with airports api
        fetchedAirports = (viewModel?.fetchListOfAirportsWith(text: text))!
        
        // Update the table with new data
        tblAirports.reloadData()
    }
  
    @IBAction func didPressDismiss(_ button:UIButton?) {
        self.dismiss(animated: true, completion: nil)
    }
}


// Dealing with list of airports
extension AirportSelectionViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedAirports.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DEFAULT_CELL_ID, for: indexPath)
        
        let airport = fetchedAirports[indexPath.row]
        
        cell.textLabel?.text = "\(airport.name) (\(airport.code))"
        cell.detailTextLabel?.text = "\(airport.cityName), \(airport.countryName)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airport = fetchedAirports[indexPath.row]
        
        if airport.code == naAirportID {
            show(errorMessage: FlyErrorMessages.SAME_AIRPORT_Message)
            return
        }
        
        if let dlgt = self.delegate {
            dlgt.userDidSelectAirport(airport: airport, OfType: airportType)
        }
        self.didPressDismiss(nil)
    }
}

extension AirportSelectionViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text!.count >= 2 {
            updateAirportsWithText(textField.text!)
        }
        
        return true
    }
}
