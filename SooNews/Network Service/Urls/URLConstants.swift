//
//  URLConstants.swift
//  SooNews
//
//  Created by Kishan Gupta on 26/04/19.
//  Copyright © 2019 KishanGupta. All rights reserved.
//

import Foundation
//URLConstants.swift

struct APPURL {
    
    private struct Domains {
        static let Dev = "https://newsapi.org"
        static let Stage = "https://newsapi.org"
    }
    
    private  struct Routes {
        static let Api = "/v2/top-headlines?"
    }
    
    private  static let Domain = Domains.Dev
    private  static let Route = Routes.Api
    private  static let BaseURL = Domain + Route
    
    static var NewsApi: String {
        return BaseURL  + "country=in&apiKey=0a947f494f8349378ab4e5f35d3497df"
    }
}

