//
//  ManagerJSON.swift
//  CodeChallenge
//
//  Created by Andrew Vasquez on 9/10/16.
//
// ****** Used a tutorial on the Gloss tool from Ray Wenderlich's JSON tutorial ***********
//

import Foundation

let PostURL = "https://alpha-api.app.net/stream/0/posts/stream/global"

class ManagerJSON {
    
    class func loadDataFromURL(_ url: URL, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
        
        let loadDataTask = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.ChaiOne", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(nil, statusError)
                } else {
                    completion(data, nil)
                }
            }
        }) 
        
        loadDataTask.resume()
    }
    
    class func getPostsDataFromServiceWithSuccess(_ success: @escaping ((_ postData: Data?) -> Void)) {
        
        loadDataFromURL(URL(string: PostURL)!, completion:{(data, error) -> Void in
            
            if let data = data {
                success(data)
            }
        })
    }
    
}

