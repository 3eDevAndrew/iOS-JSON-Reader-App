//
//  PostManager.swift
//  CodeChallenge
//
//  Created by Andrew Vasquez on 9/8/16.
//

import Foundation
//for UIImage only
import UIKit


protocol PostDelegate {
    func didFinishDownloadingDelegate()
}


open class PostManager{
    
    fileprivate var postArray:[Post] = []
    
    var delegate:PostDelegate? = nil
    
    func getPostsCount()->Int{
        
        return postArray.count
    }
    
    func getPostAvatarAtIndex(_ index:Int)->UIImage?{
        
        if postArray.count <= index{
            NSLog("Houston AVATAR problem")
            return #imageLiteral(resourceName: "Login_logo")
        }
        
        return self.postArray[index].avatar
    }
    
    func getPostNameAtIndex(_ index:Int)->String?{
        
        
        if postArray.count <= index{
            NSLog("Houston NAME problem")
            return "Loading..."
        }
        
        return postArray[index].name
    }
    
    func getPostPostAtIndex(_ index:Int)->String?{
        
        if postArray.count <= index{
            NSLog("Houston POST problem")
            return "Loading..."
        }
        
        return postArray[index].postText
    }
    
    func Refresh(){

        self.DownloadPosts()
        
    }
    
    fileprivate func DownloadPosts(){
        
    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                // do some task
        ManagerJSON.getPostsDataFromServiceWithSuccess { (data) -> Void in
            // TODO: Process data
            
            var json: [String: AnyObject]!
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions()) as? [String:AnyObject]
            } catch{
                print(error)
            }
            
            guard let publicPosts = ParentJSON(json: json) else {
                print("Error initializing object")
                return
            }
            
            self.postArray.removeAll()
            
            //set posts to an internal data structure to host all up to date posts
            for postjson in publicPosts.posts! {
                let newPost = Post()
                let avatarImage = self.convertAvatarURLtoImage(postjson.avatar!)
                newPost.avatar = avatarImage
                newPost.name = postjson.name
                newPost.postText = postjson.post
                self.postArray.append(newPost)
            }
            
            if ((self.delegate) != nil){
                self.delegate?.didFinishDownloadingDelegate()
            }
            
            
            //Signal the table to reload
            //let postNotificationKey = "pingedFromModelUpdatesAreReady"
            //NotificationCenter.default.post(name: Notification.Name(rawValue: postNotificationKey), object: self)
            }
        
        }

    }
    
    func convertAvatarURLtoImage(_ avatarURL:String)->UIImage?{
        
        guard let url = URL(string: avatarURL),
            let data = try? Data(contentsOf: url)
            else { return nil}
        
        return UIImage(data: data)!
    }
    
    
}
