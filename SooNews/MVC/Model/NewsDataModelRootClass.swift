//
//  NewsDataModelRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 26, 2019

import Foundation
import SwiftyJSON


class NewsDataModelRootClass : NSObject, NSCoding{

    var status : String!
    var totalResults : Int!
    var articles : [NewsDataModelArticle]!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        status = json["status"].stringValue
        totalResults = json["totalResults"].intValue
        articles = [NewsDataModelArticle]()
        let articlesArray = json["articles"].arrayValue
        for articlesJson in articlesArray{
            let value = NewsDataModelArticle(fromJson: articlesJson)
            articles.append(value)
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()
        if status != nil{
        	dictionary["status"] = status
        }
        if totalResults != nil{
        	dictionary["totalResults"] = totalResults
        }
        if articles != nil{
        var dictionaryElements = [[String:Any]]()
        for articlesElement in articles {
        	dictionaryElements.append(articlesElement.toDictionary())
        }
        dictionary["articles"] = dictionaryElements
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		status = aDecoder.decodeObject(forKey: "status") as? String
		totalResults = aDecoder.decodeObject(forKey: "totalResults") as? Int
		articles = aDecoder.decodeObject(forKey: "articles") as? [NewsDataModelArticle]
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if totalResults != nil{
			aCoder.encode(totalResults, forKey: "totalResults")
		}
		if articles != nil{
			aCoder.encode(articles, forKey: "articles")
		}

	}

}
