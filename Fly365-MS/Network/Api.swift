//
//  Api.swift
//  Tasawwaq
//
//  Created by Mohammed Salah on 9/5/18.
//

import UIKit
import Alamofire
import PromiseKit

class Api: NSObject {

    var requestType: Requestable?
    var result = ""
    
    
    func getApiName() ->String {
        return ""
    }
    
}


class StatisticsAPI: Api {

    var token: String = ""
}


extension StatisticsAPI {

    enum APIRouter: Requestable {

        case statistics(StatisticsAPI)

        var path: String {
            return ""
        }

        var method: HTTPMethod {
            return .post
        }

        var module: ApiModule? {
            return .statistics
        }

        var parameters: Parameters? {
            switch self {
            case .statistics(let store): return [ServerKeys.user_token:store.token]
            }
        }
    }
}

extension StatisticsAPI {

    func getAllStatistics() -> Promise<Statistics>  {
        return Promise { (fulfil, reject) in
            let completionHandler: (DataResponse<Statistics>) -> Void = { response in
                guard response.error == nil else {
                    reject(response.error!)
                    return
                }
                guard response.value != nil else {
                    _ = NSError(domain: "JSONResponseError", code: 3841, userInfo: nil)
                    reject(response.error!)
                    return
                }
                fulfil((response.result.value ?? Statistics()))
            }

            APIRouter.statistics(self).request(with:completionHandler)
        }
    }

}

class Statistics: Codable {
    var addressNo = 0
    var ordersNo = 0
    var previousOrderNno = 0
    var favouriteStoresNo = 0
    var wishlistNo = 0
    var notificationsNo = 0

    private enum CodingKeys: String, CodingKey {
        case addressNo = "address_no"
        case ordersNo = "orders_no"
        case previousOrderNno = "my_previous_order_no"
        case favouriteStoresNo = "favourite_stores_no"
        case wishlistNo = "my_wish_list_no"
        case notificationsNo = "notifications_no"

    }
}
