
import Foundation
 
public class Articles {
	public var id : String?
	public var createdAt : String?
	public var content : String?
	public var comments : Int?
	public var likes : Int?
	public var media : Array<Media>?
	public var user : Array<User>?


    public class func modelsFromDictionaryArray(array:Array<Dictionary<String,Any>>) -> [Articles]
    {
        var models:[Articles] = []
        for item in array
        {
            models.append(Articles(dictionary: item )!)
        }
        return models
    }


	required public init?(dictionary: Dictionary<String,Any>) {

		id = dictionary["id"] as? String
		createdAt = dictionary["createdAt"] as? String
		content = dictionary["content"] as? String
		comments = dictionary["comments"] as? Int
		likes = dictionary["likes"] as? Int
        if (dictionary["media"] != nil) { media = Media.modelsFromDictionaryArray(array: dictionary["media"] as! Array<Dictionary<String,Any>>) }
        if (dictionary["user"] != nil) { user = User.modelsFromDictionaryArray(array: dictionary["user"] as! Array<Dictionary<String,Any>>) }
	}

		

    public func dictionaryRepresentation() -> Dictionary<String,Any> {
        
        let dictionary = NSMutableDictionary()
        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.createdAt, forKey: "createdAt")
        dictionary.setValue(self.content, forKey: "content")
        dictionary.setValue(self.comments, forKey: "comments")
        dictionary.setValue(self.likes, forKey: "likes")
        dictionary["media"]   = Media.arrayRepresentation(for: media!)
        dictionary["user"]  = User.arrayRepresentation(for: user!)
        return dictionary as! Dictionary<String,Any>
    }
    
    func saveData(){
        CoreDataStackManager.sharedManager.saveArticle(with: [self])
    }

}
