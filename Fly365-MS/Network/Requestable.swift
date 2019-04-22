//
//  TripViewModel.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//
import Alamofire
import CodableAlamofire

protocol Requestable: URLRequestConvertible {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var module: ApiModule? { get }
    var parameters: Parameters? { get }
    var timeoutIntervalForRequest: TimeInterval { get }
    
    @discardableResult
    func request<T: Codable>(with responseObject: @escaping (DataResponse<T>) -> Void) -> DataRequest
    
    @discardableResult
    func request<T: Codable>(with responseArray: @escaping (DataResponse<[T]>) -> Void) -> DataRequest
}

extension Requestable {
    
    // method is post by default 🙄
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
    // just to add nil as default parameter
    var parameters: Parameters? {
        return nil
    }
    
    // default timeoutIntervalForRequest
    var timeoutIntervalForRequest: TimeInterval {
        return 60.0
    }
    
    @discardableResult
    func request<T: Codable>(with responseObject: @escaping (DataResponse<T>) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).responseDecodableObject(completionHandler: responseObject).validateErrors()
    }
    
    @discardableResult
    func request<T: Codable>(with responseArray: @escaping (DataResponse<[T]>) -> Void) -> DataRequest {
        return ServiceManager.shared.request(self).responseDecodableObject(completionHandler: responseArray).validateErrors()
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        // update timeoutIntervalForRequest from router
        ServiceManager.shared.manager.session.configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        
        var url = ServiceManager.API.baseUrl.appendingPathComponent((module?.name)!)
        
        if !path.isEmpty {
            url = url.appendingPathComponent(path)
        }
        
        // get ApiKey
        let apiKeyPath = Bundle.main.url(forResource: "Api", withExtension: "plist")
        let dictionary = NSDictionary.init(contentsOf: apiKeyPath!)
        let apiKey = dictionary!["ApiKey"]
    
        var urlRequest = try URLRequest(url: url, method: method)
        urlRequest.addValue(apiKey as! String, forHTTPHeaderField: ServerKeys.authorization)
        urlRequest.addValue(ServerKeys.contentValue, forHTTPHeaderField: ServerKeys.content)
        
        print("\(url.absoluteString)")
        
        return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
    }
    
    fileprivate func asURLRequest() -> String {
        
        
        var url = ServiceManager.API.baseUrl.appendingPathComponent((module?.name)!)
        
        if !path.isEmpty {
            url = url.appendingPathComponent(path)
        }
        
        
        return url.absoluteString
    }
}

enum ApiModule: String {
    
    case searchForFlights

    var name: String {
        switch self {
        case .searchForFlights: return "search"
        }
    }
}
