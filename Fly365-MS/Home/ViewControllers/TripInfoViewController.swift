//
//  TripInfoViewController.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit




class TripInfoViewController: UIViewController {

    weak var delegate:TripInfoDelegate?
    var selectedFlightClass = FlightClass.Economy
    var viewModel:TripInfoViewModel?
    
    @IBOutlet weak var lblAdultCount: UILabel!
    @IBOutlet weak var lblChildCount: UILabel!
    @IBOutlet weak var lblInfantCount: UILabel!
    
    @IBOutlet weak var btnClass: RoundedCornersButton!
    @IBOutlet weak var pickerFlightClass: UIPickerView!
    @IBOutlet weak var btnAdultPlus: RoundedCornersButton!
    @IBOutlet weak var btnAdultMinus: RoundedCornersButton!
    @IBOutlet weak var btnChildPlus: RoundedCornersButton!
    @IBOutlet weak var btnChildMinus: RoundedCornersButton!
    @IBOutlet weak var btnInfantPlus: RoundedCornersButton!
    @IBOutlet weak var btnInfantMinus: RoundedCornersButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerFlightClass.delegate = self
        pickerFlightClass.dataSource = self
        pickerFlightClass.isHidden = true
        
        viewModel?.didUpdateValue = updateUI
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        lblAdultCount.text = String(viewModel!.adult)
        lblChildCount.text = String(viewModel!.child)
        lblInfantCount.text = String(viewModel!.infant)
        btnClass.setTitle(viewModel?.flightClass.rawValue, for: .normal)
    }
    
    @IBAction func didPressDismiss(_ button:UIButton?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressApply(_ sender: UIButton) {
        if let dlgt = delegate {
            
            dlgt.tripInfoChanged(Int(lblAdultCount.text!)!, Int(lblChildCount.text!)!, Int(lblInfantCount.text!)!, (selectedFlightClass))
        }
        didPressDismiss(nil)
    }
    
    
    
    @IBAction func didPressChangePassnagers(_ button: RoundedCornersButton) {
        var label = lblAdultCount
        var state = PassangerType.Adult
       
        if button == btnChildPlus || button == btnChildMinus {
            label = lblChildCount
            state = PassangerType.Child
        } else if button == btnInfantPlus || button == btnInfantMinus {
            label = lblInfantCount
            state = PassangerType.Infant
        }
        
        var value = viewModel?.getValueOfType(passangerType: state)
       
        // 10 means increase the current value
        if button.tag == 10 {
            value = value! + 1
            
            //Validate
            let error = viewModel?.validateNumberOfPassangers(passangerType: state, newValue: value!)
            
            if !(error?.isEmpty)! {
                show(errorMessage: error!)
                return
            }
            
        } else if button.tag == 5 && value! > 0 {
            value = value! - 1
            
            // verify adult lable is greater than or equal 1
            if value! < 1 && label == lblAdultCount {
                value = 1
            }
        }
        
        viewModel?.setValueOfType(passangerType: state, value: value!)
        label?.text = String(value!)
        
    }
    
    @IBAction func didSelectFlightClass(_ sender: RoundedCornersButton) {
        pickerFlightClass.isHidden = false
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

extension TripInfoViewController: UIPickerViewDataSource ,UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerFlightClass.isHidden = true
        selectedFlightClass = FlightClass.element(at: row)!
        btnClass.setTitle(selectedFlightClass.rawValue, for: .normal)
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FlightClass.elements().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FlightClass.element(at: row)?.rawValue
    }
}
