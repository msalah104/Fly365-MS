//
//  SearchResultsViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/20/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class SearchResultsViewController: BaseViewController {

    var viewModel:SearchViewModel!
    var from = ""
    var to = ""
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var lblAirPortDetails: UILabel!
    @IBOutlet weak var lblResultDetails: UILabel!
    @IBOutlet weak var tblFlights: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.didUpdateResults = updateUI
        tblFlights.register(UINib.init(nibName: "SearchResultCellTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.CELL_REUSE_ID)
        fetchViewData()
    }
    
    override func setupView() {
        tblFlights.tableFooterView = UIView.init(frame: CGRect.zero)
        tblFlights.backgroundColor = UIColor.clear
    }
    
    func fetchViewData() {
        self.showProgress()
        viewModel.submitSearch()
    }
    
    func updateUI()  {
        self.hideProgress()
        
        if viewModel.allFlightList.isEmpty {
            // Show empty view
            noDataView.isHidden = false
        } else {
            // Show flights
            lblResultDetails.text = "\(viewModel.flightsList.count) Flights"
            lblAirPortDetails.text = "\(viewModel.tripRequestForm.steps[0].origin!.code) - \(viewModel.tripRequestForm.steps[0].destination!.code) "
            tblFlights.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == StoryBoards.Search.Segues.filter {
            let vc = (segue.destination as! UINavigationController).viewControllers.first as! FilterViewController
            vc.viewModel = viewModel.filterViewModel
            
        }
    }
    
    
    @IBAction func didPressBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressFliter(_ sender: Any) {
//        viewModel.fakeFilter()
    }
    
    @IBAction func didPressSort(_ sender: Any) {
    }
    
}


extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.flightsList.count
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_REUSE_ID, for: indexPath) as! SearchResultCellTableViewCell
        
        let flight = viewModel.flightsList[indexPath.row]
        
        if !cell.flighViews.isEmpty {
            cell.clearFlightViews()
        }
        
        for leg in flight.flightLegs! {
            cell.addLeg(leg: leg)
        }
        
        cell.lblPrice.text = "\(flight.pricing!.total) \(flight.pricing!.currencyCode)"
        cell.lblStops.text = "Total Stops: \(flight.totalStops)"
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        
        return cell
    }
}
