//
//  NetworkCall.swift
//  SooNews
//
//  Created by Kishan Gupta on 26/04/19.
//  Copyright © 2019 KishanGupta. All rights reserved.
//

import Foundation
import SwiftyJSON

class Service{
    
    func serviceCall(headers : Dictionary<String, String>, url : String, httpMethod : String, success : @escaping (JSON) -> Void,failure : @escaping (String) -> Void){
        
        let headers = headers
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 20.0)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                let errorMsg = error.unsafelyUnwrapped.localizedDescription
                failure(errorMsg)
            } else {
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        let errorMsg = self.handlingFailureCases((response as! HTTPURLResponse).statusCode)
                        failure(errorMsg)
                        return
                }
                    success(JSON.init(data!))
            }
        })
        
        dataTask.resume()
    }
    
    func handlingFailureCases(_ statusCode: Int) -> String {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "errorWhileSendingRequest"), object: nil)
        var errorMsg: String!
        switch statusCode{
        case 401:
            errorMsg = "Session has been expired.Press ok to re-login"
        case 402 ... 499:
            errorMsg = "An error Occured"
        case 500 ... 510:
            errorMsg = "The server failed to fulfill an apparently valid request."
        case 900 :
            errorMsg = "An error Occured"
        case -1020 ... -1001:
            errorMsg = "Server couldn't be reached. Please try again later"
        default:
            errorMsg = "Unable to connect to the server"
        }
        return errorMsg
    }
    
}
