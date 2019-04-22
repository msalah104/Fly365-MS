//
//  BaseViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let DEFAULT_CELL_ID = "cell_ID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        print("Base \(self)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupView() {
        
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
