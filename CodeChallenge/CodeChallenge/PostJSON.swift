//
//  PostJSON.swift
//  CodeChallenge
//
//  Created by Andrew Vasquez on 9/8/16.
//

struct PostJSON: Decodable {
    var avatar: String?
    var name: String?
    var post: String?
    
    init?(json: JSON) {
        
        guard let userContainer: JSON = "user" <~~ json,
            let postText: String = "text" <~~ json
            else{ return nil }
        
        
        guard let name: String = "username" <~~ userContainer,
            let avatarContainer: JSON = "avatar_image" <~~ userContainer
            else{return nil}
        
        let avatar:String = ("url" <~~ avatarContainer)!
        
        self.avatar = avatar
        self.name = name
        self.post = postText
        
    }
}
