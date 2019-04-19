//
//  AirportsViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/18/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class AirportsViewModel: BaseViewModel{

    fileprivate var airports = [Airport]()
    
    fileprivate func loadLoacalStaticAirports() {
        do{
            let url = Bundle.main.url(forResource: "airport", withExtension: "json")
            let data = try Data.init(contentsOf: url!)
            airports = try JSONDecoder().decode([Airport].self, from: data)
        } catch{
            fatalError("Error Loading Json File")
        }
    }
    
    func fetchListOfAirportsWith(text:String) -> [Airport] {
        loadLoacalStaticAirports()
        
        if airports.count > 0 {
            return airports
        } else {
            return [Airport]()
        }
    }
}
