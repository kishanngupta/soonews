//
//  NewsDataModelArticle.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 26, 2019

import Foundation
import SwiftyJSON


class NewsDataModelArticle : NSObject, NSCoding{

    var source : NewsDataModelSource!
    var author : String!
    var title : String!
    var descriptionField : String!
    var url : String!
    var urlToImage : String!
    var publishedAt : String!
    var content : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        let sourceJson = json["source"]
        if !sourceJson.isEmpty{
            source = NewsDataModelSource(fromJson: sourceJson)
        }
        author = json["author"].stringValue
        title = json["title"].stringValue
        descriptionField = json["description"].stringValue
        url = json["url"].stringValue
        urlToImage = json["urlToImage"].stringValue
        publishedAt = json["publishedAt"].stringValue
        content = json["content"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()
        if source != nil{
        	dictionary["source"] = source.toDictionary()
        }
        if author != nil{
        	dictionary["author"] = author
        }
        if title != nil{
        	dictionary["title"] = title
        }
        if descriptionField != nil{
        	dictionary["description"] = descriptionField
        }
        if url != nil{
        	dictionary["url"] = url
        }
        if urlToImage != nil{
        	dictionary["urlToImage"] = urlToImage
        }
        if publishedAt != nil{
        	dictionary["publishedAt"] = publishedAt
        }
        if content != nil{
        	dictionary["content"] = content
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		source = aDecoder.decodeObject(forKey: "source") as? NewsDataModelSource
		author = aDecoder.decodeObject(forKey: "author") as? String
		title = aDecoder.decodeObject(forKey: "title") as? String
		descriptionField = aDecoder.decodeObject(forKey: "description") as? String
		url = aDecoder.decodeObject(forKey: "url") as? String
		urlToImage = aDecoder.decodeObject(forKey: "urlToImage") as? String
		publishedAt = aDecoder.decodeObject(forKey: "publishedAt") as? String
		content = aDecoder.decodeObject(forKey: "content") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if source != nil{
			aCoder.encode(source, forKey: "source")
		}
		if author != nil{
			aCoder.encode(author, forKey: "author")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}
		if urlToImage != nil{
			aCoder.encode(urlToImage, forKey: "urlToImage")
		}
		if publishedAt != nil{
			aCoder.encode(publishedAt, forKey: "publishedAt")
		}
		if content != nil{
			aCoder.encode(content, forKey: "content")
		}

	}

}
