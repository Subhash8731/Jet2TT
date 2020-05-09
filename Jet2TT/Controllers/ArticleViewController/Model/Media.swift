

import Foundation
 

public class Media {
	public var id : String?
	public var blogId : String?
	public var createdAt : String?
	public var image : String?
	public var title : String?
	public var url : String?


    public class func modelsFromDictionaryArray(array:Array<Dictionary<String,Any>>) -> [Media]
    {
        var models:[Media] = []
        for item in array
        {
            models.append(Media(dictionary: item )!)
        }
        return models
    }


	required public init?(dictionary: Dictionary<String,Any>) {

		id = dictionary["id"] as? String
		blogId = dictionary["blogId"] as? String
		createdAt = dictionary["createdAt"] as? String
		image = dictionary["image"] as? String
		title = dictionary["title"] as? String
		url = dictionary["url"] as? String
	}

        public class func arrayRepresentation(for data:Array<Media>) -> Array<Dictionary<String,Any>> {
            var array = Array<Dictionary<String,Any>>()
            for assesment in data {
                array.append(assesment.dictionaryRepresentation())
            }
           return array
        }

	public func dictionaryRepresentation() -> Dictionary<String,Any> {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.blogId, forKey: "blogId")
		dictionary.setValue(self.createdAt, forKey: "createdAt")
		dictionary.setValue(self.image, forKey: "image")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.url, forKey: "url")

		return dictionary as! Dictionary<String,Any>
	}

}
