//
//  TripViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyBeaver


typealias Log = SwiftyBeaver

public extension Alamofire.Request {
    
    /// Prints the log for the request
    @discardableResult
    func debug() -> Self {
        guard Configurations.mode == .development else {return self}
        Log.info(self.debugDescription)
        return self
    }
}

public extension Alamofire.DataRequest {
    
    @discardableResult
    func validateErrors() -> Self {
        return validate { [weak self] (request, response, data) -> Alamofire.Request.ValidationResult in
            
            // get status code from server
            let code = response.statusCode
            
            // check the request url
            let requestURL = String(describing: request?.url?.absoluteString ?? "NO URL")
            
            // check if response is empty
            guard let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any], let json = jsonData  else {
                self?.log(code: code, url: requestURL, message: "Empty response" as AnyObject, isError: false, request: request)
                return .success
            }
            
            var result: Alamofire.Request.ValidationResult = .success
            
            // check if response is html
            if (response.allHeaderFields["Content-Type"] as? String)?.contains("text/html") == true {
                self?.log(code: code, url: requestURL, message: json as AnyObject, isError: true, request: request)
                
                let error = NSError(domain: "html", code: -999, userInfo: ["html": data, NSLocalizedDescriptionKey: "somethingWentWrong"])
                result = .failure(error)
            }
            else if let message = (json["message"] as? String ?? json["status_code"] as? String) {
                
                //create the error object
                
                let domain = json["statusCode"] as? String ?? "error"
                if domain == "0000" {
                    let error = FlyError(code: domain, message: message)
                    
                    //log error
                    self?.log(code: code, url: requestURL, message: json as AnyObject, isError: true, request: request)
                    
                    //return failure
                    result = .failure(error)
                }
                
            }
            else {
                self?.log(code: code, url: requestURL, message: json as AnyObject, isError: false, request: request)
                result = .success
            }
            
            return result
            }
            // validate for request errors
            .validate()
            
            // log request
            .debug()
    }
    
    
    
    private func log(code: Int, url: String, message: AnyObject, isError: Bool, request: URLRequest?) {
        guard Configurations.mode == .development else {return}

        if isError {
            Log.error("FAILED")
        }
        
        Log.info("Status Code >> \(code)")
        Log.info("URL >> \(url)")
        Log.info("Request >> \(String(describing: request?.allHTTPHeaderFields))")
        Log.info("Response >> \(message)")
    }
}
