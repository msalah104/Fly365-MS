//
//  SearchResultCellTableViewCell.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/20/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class SearchResultCellTableViewCell: UITableViewCell {

    let FLIGHT_VIEW_H = 40
    let FLIGHT_VIEW_SEP = 5
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStops: UILabel!
    @IBOutlet weak var stcFlightDetailsContainer: UIStackView!
    @IBOutlet var flighViews: [FlightView]! = []
    @IBOutlet weak var cnstContainerHight: NSLayoutConstraint!
    
    @IBOutlet weak var cnstContainerWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func loadLegforIndex(index:Int, leg:Leg)
    
    func addLeg(leg:Leg){
        
        let flightView = Bundle.main.loadNibNamed("FlightView", owner: self, options: nil)?.first as! FlightView
        flighViews.append(flightView)
        
        // fill data
        flightView.lblDepTime.text = getTime(date: leg.departureDate)
        flightView.lblArrTime.text = getTime(date: leg.arrivalDate)
        flightView.lblTo.text = leg.destination
        flightView.lblFrom.text = leg.origin
        flightView.lblDuration.text = "\(leg.duration)M"
        flightView.lblAirlineName.text = leg.carrier?.name
        flightView.lblFlightNumber.text = "FN:\(leg.legSegment?.first?.carrier?.flightNumber ?? "")"
        
        if flighViews.count == 1 {
            cnstContainerHight.constant = CGFloat(FLIGHT_VIEW_H)
//            cnstContainerWidth.constant = flightView.frame.size.width
        } else {
            cnstContainerHight.constant += CGFloat(FLIGHT_VIEW_H + FLIGHT_VIEW_SEP)
//            cnstContainerWidth.constant = flightView.frame.size.width > cnstContainerWidth.constant ? flightView.frame.size.width:cnstContainerWidth.constant
        }
        stcFlightDetailsContainer.addArrangedSubview(flightView)
        
        self.setNeedsLayout()
    }
    
    func getTime(date:String) -> String {
        let splittedString = date.split(separator: "T")
        let time = String(splittedString.last!)
        return time.substring(from: 0, to: 5)
    }
    
    func clearFlightViews() {
        for flightView in flighViews {
            flightView.removeFromSuperview()
        }
        cnstContainerHight.constant = 0
    }
    
}

extension String {
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
}
