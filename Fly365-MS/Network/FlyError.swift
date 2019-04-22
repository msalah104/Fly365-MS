//
//  TripViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit
import Foundation

class FlyError: Error {
    
    var code: String?
    var message: String?
    
    init(code: String?, message: String?) {
        self.code = code
        self.message = message
    }
}

extension Error {
    
    /**
     Error code
     */
    var code: String {
        return (self as? FlyError)?.code ?? ""
    }
    
    /**
     Error message
     */
    var message: String {
        return (self as? FlyError)?.message ?? localizedDescription
    }
}
