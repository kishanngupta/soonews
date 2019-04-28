//
//  KeyConstants.swift
//  SooNews
//
//  Created by Kishan Gupta on 26/04/19.
//  Copyright © 2019 KishanGupta. All rights reserved.
//

import Foundation

//KeyConstants.swift
struct Key {
    
    static let DeviceType = "iOS"
    static let getHttpMethod = "GET"
    static let postHttpMethod = "POST"
    static let failure = "Failure"
    static let success = "Success"
    static let ok = "Ok"
    static let cancel = "Cancel"
    
    struct UserDefaults {
        static let someKey = "someKey"
    }
    
    struct Headers {
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        static let cacheControl = "Cache-Control"
    }
    
    struct ErrorMessage{
        static let listNotFound = "ERROR_LIST_NOT_FOUND"
        static let validationError = "ERROR_VALIDATION"
    }
}
