//
//  Criteria.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/21/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit

protocol Criteria: class {

    func meetCriteria (flights:[Flight]) -> [Flight]
        
    init(options:[Any])
}
