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

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
        settings.tabBackgroundColor = #colorLiteral(red: 0.1346258223, green: 0.1712838709, blue: 0.2785593569, alpha: 1)
        settings.tabButtonColor = #colorLiteral(red: 0.1346258223, green: 0.1712838709, blue: 0.2785593569, alpha: 1)
        
        tabFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        self.viewControllers = getTabs()
        
        
        
    }
    
    func getTabs() -> [UIViewController]{
        // instantiate the viewControllers
        let airplaneViewController = self.storyboard?.instantiateViewController(withIdentifier: "airplaneViewController")
        let giftViewController = self.storyboard?.instantiateViewController(withIdentifier: "giftViewController")
        let shoeViewController = self.storyboard?.instantiateViewController(withIdentifier: "shoeViewController")
        
        // set the title for the tabs
        airplaneViewController?.title = "One Way"
        shoeViewController?.title = "Round Trip"
        giftViewController?.title = "Multi City"
        
        return [airplaneViewController!,giftViewController!,shoeViewController!]
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
