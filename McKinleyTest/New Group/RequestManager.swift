//
//  RequestManager.swift
//  McKinleyTest
//
//  Created by Abhishek on 19/12/19.
//  Copyright © 2019 Evontech. All rights reserved.
//

import Foundation
import Alamofire

typealias onCompletion = (_ response: AnyObject?, _ error: AnyObject?, _ message: String?) -> Void
let BASE_URL = "https://reqres.in/api/"
class RequestManager{
    
    static let sharedManager = RequestManager()
    let manager = Alamofire.SessionManager.default
    var contentType = "application/x-www-form-urlencoded"
    
    //Post request manager function to call the apis
    func connectToServerPost(urlString: String,  param: [String : Any], completion: @escaping onCompletion) {
        manager.session.configuration.timeoutIntervalForRequest = 15
        let headers = [
            "Content-Type": contentType
        ]
        manager.request(urlString, method: .post, parameters: param, encoding: URLEncoding.default, headers: headers).responseString { _ in }
            .responseJSON { (jsonResponse) in
                if jsonResponse.value != nil {
                    completion(jsonResponse.value! as AnyObject, nil, nil)
                } else {
                    let error = jsonResponse.error! as NSError
                    completion(nil, error, nil)
                }
        }
    }
    
}
