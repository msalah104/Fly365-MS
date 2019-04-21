//
//  TAError.swift
//  Tasawwaq
//
//  Created by Marwan on 9/1/18.
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
