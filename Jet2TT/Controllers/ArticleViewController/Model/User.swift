
import Foundation
 

public class User {
	public var id : String?
	public var blogId : String?
	public var createdAt : String?
	public var name : String?
	public var avatar : String?
	public var lastname : String?
	public var city : String?
	public var designation : String?
	public var about : String?


    public class func modelsFromDictionaryArray(array:Array<Dictionary<String,Any>>) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item )!)
        }
        return models
    }


	required public init?(dictionary: Dictionary<String,Any>) {

		id = dictionary["id"] as? String
		blogId = dictionary["blogId"] as? String
		createdAt = dictionary["createdAt"] as? String
		name = dictionary["name"] as? String
		avatar = dictionary["avatar"] as? String
		lastname = dictionary["lastname"] as? String
		city = dictionary["city"] as? String
		designation = dictionary["designation"] as? String
		about = dictionary["about"] as? String
	}

        public class func arrayRepresentation(for data:Array<User>) -> Array<Dictionary<String,Any>> {
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
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.avatar, forKey: "avatar")
		dictionary.setValue(self.lastname, forKey: "lastname")
		dictionary.setValue(self.city, forKey: "city")
		dictionary.setValue(self.designation, forKey: "designation")
		dictionary.setValue(self.about, forKey: "about")

		return dictionary as! Dictionary<String,Any>
	}

}
