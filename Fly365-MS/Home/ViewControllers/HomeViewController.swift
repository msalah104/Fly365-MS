//
//  HomeViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/17/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class HomeViewController: AMPagerTabsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        settings.tabBackgroundColor = #colorLiteral(red: 0.1346258223, green: 0.1712838709, blue: 0.2785593569, alpha: 1)
        settings.tabButtonColor = #colorLiteral(red: 0.1346258223, green: 0.1712838709, blue: 0.2785593569, alpha: 1)
        
        tabFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        self.viewControllers = getTabs()
    }
    
    
    func getTabs() -> [UIViewController]{
        // instantiate the viewControllers
        let oneWayViewController = self.storyboard?.instantiateViewController(withIdentifier: "oneWayViewController")
        let roundTripViewController = self.storyboard?.instantiateViewController(withIdentifier: "roundTripViewController")
        let multiCityViewController = self.storyboard?.instantiateViewController(withIdentifier: "multiCityViewController")
        
        // set the title for the tabs
        oneWayViewController?.title = "One Way"
        roundTripViewController?.title = "Round Trip"
        multiCityViewController?.title = "Multi City"
        
        return [oneWayViewController!,roundTripViewController!,multiCityViewController!]
    }

}
