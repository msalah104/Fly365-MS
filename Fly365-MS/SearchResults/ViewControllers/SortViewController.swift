//
//  SortViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {

    @IBOutlet weak var tblSort: UITableView!
    var selectedSortType = SearchResultsSortType.Cheapest
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 

}

extension SortViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row + 1)", for: indexPath)
        
        cell.textLabel?.text = SearchResultsSortType.elements()[indexPath.row].rawValue
        cell.accessoryType = .none
        
        if selectedSortType == SearchResultsSortType.elements()[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSortType = SearchResultsSortType.elements()[indexPath.row]
        tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
