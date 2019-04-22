//
//  FliterTableViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

enum FilterDataType {
    case Stopps
    case Airlines
    case Airports
}

class FilterTableViewController: UIViewController {

    var dataSource = [String]()
    var selectedItems = [String]()
    var dataType = FilterDataType.Stopps
    var viewModel:FilterManagerDataSource!
    
    @IBOutlet weak var tblFilter:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblFilter.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
    */
    
    @IBAction func didPressApply(_ sender: RoundedCornersButton) {
        if dataType == .Stopps {
            viewModel.updateSelectedStopps(stopps: selectedItems.map({Int($0)!}))
        } else if dataType == .Airports {
            viewModel.updateSelectedAirports(airports: selectedItems)
        } else if dataType == .Airlines {
            viewModel.updateSelectedAirlines(airlines: selectedItems)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension FilterTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_REUSE_ID, for: indexPath)
        let item = dataSource[indexPath.row]
        
        if selectedItems.contains(where: {$0 == item}) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = item
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        
        if selectedItems.contains(item) {
            selectedItems.remove(at: selectedItems.firstIndex(of: item)!)
        } else {
            selectedItems.append(item)
        }
        
        tableView.reloadData()
        
    }
}
