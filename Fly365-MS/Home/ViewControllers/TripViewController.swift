//
//  TripViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {

    @IBOutlet weak var btnOrigin:RoundedCornersButton!
    @IBOutlet weak var btnDeparture:RoundedCornersButton!
    @IBOutlet weak var btnDestination:RoundedCornersButton!
    @IBOutlet weak var btnSwitch:RoundedCornersButton!
    @IBOutlet weak var btnPassangers:RoundedCornersButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - IBActions
    @IBAction func didPressPassangers(_ button:UIButton) {
        performSegue(withIdentifier: StoryboardsSegues.SELECT_PASSANGER, sender: nil)
    }
    
    @IBAction func didPressOrigin(_ button:UIButton) {
        
    }
    
    @IBAction func didPressDestination(_ button:UIButton) {
        
    }
    
    @IBAction func didPressSwitch(_ button:UIButton) {
        
    }
    
    @IBAction func didPressDeparture(_ button:UIButton) {
        
    }
}
