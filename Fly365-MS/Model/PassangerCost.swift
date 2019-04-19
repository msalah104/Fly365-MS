//
//  PassangerCost.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

class PassangerCost: Codable {
    var ADT:ADTPrice?
}

class ADTPrice: Codable {
    var code = ""
    var count = 0
    var base = 0.0
    var tax = 0.0
    var total = 0.0
}
