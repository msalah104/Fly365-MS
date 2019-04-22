//
//  SearchApi.swift
//  Fly365-MS
//
//  Created by Mohammed Salah on 4/19/19.
//  Copyright © 2019 Mohammed Salah. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class SearchApi: Api {
    
    private var tripFormRequest:TripFormRequest!
    
    
    init(requestParams:TripFormRequest) {
        super.init()
        self.tripFormRequest = requestParams
    }
    
    private func getSearchParams() -> Dictionary<String, Any> {
        
        var legs:[Dictionary<String, Any>] = []
        for leg in tripFormRequest.steps {
            let step = [ServerKeys.origin:leg.origin?.code ?? "", ServerKeys.destination:leg.destination?.code ?? "", ServerKeys.departureDate:FlyUtils.ParamtersDateFormate(date: leg.date!)] as [String : Any]
            legs.append(step)
        }
        
        return [ServerKeys.adult:tripFormRequest.adult, ServerKeys.child:tripFormRequest.child, ServerKeys.infant:tripFormRequest.infant, ServerKeys.cabinClass:tripFormRequest.flightClass.rawValue , ServerKeys.legs:legs]
    }

}

extension SearchApi {
    
    enum APIRouter: Requestable {
        
        case searchForFlights(SearchApi)
        //case editaddress
        var path: String {
            return ""
        }
        
        var method: HTTPMethod {
            return .post
        }
        
        var module: ApiModule? {
            switch self {
            case .searchForFlights(_): return .searchForFlights
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case .searchForFlights(let searchApi): return searchApi.getSearchParams()
            }
        }
    }
}

extension SearchApi {
    
    func searchForFlights() -> Promise<FlightSearchResponse>  {
        return Promise { (fulfil, reject) in
            let completionHandler: (DataResponse<FlightSearchResponse>) -> Void = { response in
                guard response.error == nil else {
                    if let err = response.error as? URLError, err.code == .notConnectedToInternet {
                        // no internet connection
                        let errorN = FlyError(code: err.code, message: FlyErrorMessages.NO_Internat_Connection_Message)
                        reject(errorN)
                        return
                    }
                    reject(response.error!)
                    return
                }
                guard response.value != nil else {
                    _ = NSError(domain: "JSONResponseError", code: 3841, userInfo: nil)
                    reject(response.error!)
                    return
                }
                fulfil((response.result.value ?? FlightSearchResponse()))
            }
            
            APIRouter.searchForFlights(self).request(with:completionHandler)
        }
    }
}
