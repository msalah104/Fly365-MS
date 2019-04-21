//
//  Requestable.swift
//  Tasawwaq
//
//  Created by Marwan on 9/1/18.
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
        
        let urlRequest = try URLRequest(url: url, method: method)
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
    
    case login
    case signup
    case allCountries
    case allCities
    case allCategories
    case allDetailsCategories
    case productsubcategories
    case addStoreToFav
    case getStorePreOrders
    case getAvailableStores
    case verify
    case resend
    case updateUserDetails
    case forgetPass
    case cart
    case getAllProductsForStore
    case refreshUserToken
    case addtocart
    case wishlist
    case addtowishlist
    case addNewAddress
    case editcart
    case addresses
    case addorder
    case orderdetails
    case addItermToFav
    case deladdress
    case orders
    case myorders
    case ordersdurations
    case pay
    case eligibilty
    case returns
    case processdorder
    case editorder
    case getAllFAQs
    case contact
    case statistics
    case searchWithText
    case marketdetails
    case offers
    case myallorders
    case notifications
    case readNotifications
    case rateStores

    var name: String {
        switch self {
        case .login: return "login"
        case .signup: return "register"
        case .allCountries: return "countries"
        case .allCities: return "cities"
        case .allCategories: return "categories"
        case .allDetailsCategories: return "productcategories"
        case .addStoreToFav: return "favorites"
        case .getStorePreOrders: return "myorders"
        case .getAvailableStores: return "stores"
        case .verify: return "verify"
        case .resend: return "mobile"
        case .updateUserDetails: return "update"
        case .forgetPass: return "forget"
        case .cart: return "cart"
        case .getAllProductsForStore: return "marketproducts"
        case .refreshUserToken: return "refresh"
        case .addtocart: return "addtocart"
        case .wishlist: return "wishlist"
        case .addtowishlist: return "addtowishlist"
        case .addNewAddress: return "addaddress"
        case .editcart: return "editcart"
        case .addItermToFav: return "addtowishlist"
        case .addresses : return "addresses"
        case .addorder: return "addorder"
        case .orderdetails: return "orderdetails"
        case .deladdress: return "deladdress"
        case .orders: return "orders"
        case .myorders: return "myorders"
        case .ordersdurations: return "ordersdurations"
        case .productsubcategories: return "productsubcategories"
        case .pay: return "pay"
        case .eligibilty: return "eligibilty"
        case .returns: return "returns"
        case .processdorder: return "processdorder"
        case .editorder: return "editorder"
        case .getAllFAQs: return "faq"
        case .contact: return "contact"
        case .statistics: return "statistics"
        case .searchWithText: return "searchproducts"
        case .offers: return "offers"
        case .marketdetails: return "marketdetails"
        case .myallorders: return "myallorders"
        case .notifications: return "notifications"
        case .readNotifications: return "read"
        case .rateStores: return "rateapp"
        }
    }
}
