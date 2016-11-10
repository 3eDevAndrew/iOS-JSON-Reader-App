//
//  ParentJSON.swift
//  CodeChallenge
//
//  Created by Andrew Vasquez on 9/8/16.
//

struct ParentJSON: Decodable {
    
    let  posts: [PostJSON]?
    
    init?(json: JSON) {
        posts = "data" <~~ json
    }
}
