//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Andrew Vasquez on 9/8/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PostDelegate {

    
    @IBOutlet weak var publicTimeLineTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var posts = PostManager()
    
    //Model to Controller communication using Notifications
    let postNotificationKey = "pingedFromModelUpdatesAreReady"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts.delegate = self;
        
        //Model to Controller communication using Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.didReceiveUpdatePostsNotification), name: NSNotification.Name(rawValue: postNotificationKey), object: nil)
        
        self.publicTimeLineTableView.addSubview(self.refreshControl)
        self.posts.Refresh()
        self.activityIndicator.startAnimating()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    //Model to Controller communcation using Delegates
    func didFinishDownloadingDelegate(){
        print("Delegate Called")

        DispatchQueue.main.async {
            self.publicTimeLineTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
        }
    }
    
    //Model to Controller communication using Notifications
    func didReceiveUpdatePostsNotification(){
        print("Notification Called")
        
        DispatchQueue.main.async {
            self.publicTimeLineTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
        }
    }
    
    //TableView Delegates
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.posts.Refresh()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.getPostsCount()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.publicTimeLineTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomPostCell
        
        cell.avatarUIImage.image = posts.getPostAvatarAtIndex((indexPath as NSIndexPath).row)
        cell.avatarUIImage.layer.cornerRadius = 17.0
        cell.avatarUIImage.layer.masksToBounds = true
        cell.postName.text = posts.getPostNameAtIndex((indexPath as NSIndexPath).row)
        cell.postedText.text = posts.getPostPostAtIndex((indexPath as NSIndexPath).row)
    
        
        return cell
        
    }
    
    
}

