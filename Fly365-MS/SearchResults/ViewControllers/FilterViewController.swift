//
//  FilterViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tblFilter:UITableView!
    
    var viewModel:FilterManagerDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

       tblFilter.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cv = segue.destination as! FilterTableViewController
        
        if segue.identifier == StoryBoards.Search.Segues.stopps {
            cv.dataSource = viewModel.getStoppsList().map({String($0)})
            cv.selectedItems = viewModel.getSelectedStopps().map({String($0)})
            cv.dataType = .Stopps
        } else if segue.identifier == StoryBoards.Search.Segues.airlines {
            cv.dataSource = viewModel.getAirlinesList()
            cv.selectedItems = viewModel.getSelectedAirlines()
            cv.dataType = .Airlines
        } else if segue.identifier == StoryBoards.Search.Segues.airports {
            cv.dataSource = viewModel.getAirportsList()
            cv.selectedItems = viewModel.getSelectedAirports()
            cv.dataType = .Airports
        }
        
        cv.viewModel = viewModel
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func didPressDismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressApply(_ sender: RoundedCornersButton) {
        viewModel.applyFilter()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressClear(_ sender: RoundedCornersButton) {
        viewModel.updateSelectedAirlines(airlines: [])
        viewModel.updateSelectedAirports(airports: [])
        viewModel.updateSelectedStopps(stopps: [])
        viewModel.applyFilter()
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell\(indexPath.row +  1)", for: indexPath)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
