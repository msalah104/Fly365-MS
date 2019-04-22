//
//  TripViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//
import UIKit

import Alamofire

typealias JSON = [String: Any]
typealias RequestCompletion =  (_ response: Any?, _ error: Error?) -> Swift.Void

class ServiceManager {
    
    static let shared = ServiceManager()
    
    var manager: Alamofire.SessionManager
    
    private init() {
        
        // manager
        manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        
        manager.adapter = ServiceAdapter()
        
    }
    
    func request(_ urlRequest: URLRequestConvertible)  -> DataRequest {
         return manager.request(urlRequest)
    }
    
}

extension ServiceManager {
    class ServiceAdapter: RequestAdapter {
        
        func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            
            // update default http headers
            urlRequest.allHTTPHeaderFields?.merge(Alamofire.SessionManager.defaultHTTPHeaders) { (current, _) in current }
            
            // customize
            return urlRequest
        }
    }
}

extension ServiceManager {
    struct API {
        static var baseUrl: URL {
            return URL(string: Constants.BASE_URL)!
        }
    }
}
