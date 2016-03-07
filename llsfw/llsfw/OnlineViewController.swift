//
//  OnlineViewController.swift
//  llsfw
//
//  Created by Lamb on 16/3/7.
//  Copyright © 2016年 gm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OnlineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var data: JSON?
    let url = "http://192.168.16.85:8080/llsfw-webdemo/api/ApiPortalController/loadOnlineSecctionData"
    
    // 处理点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("tableView click")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = data?.arrayValue {
            return list.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Table Cell", forIndexPath: indexPath)
        let item = data?.arrayValue[indexPath.row]
        cell.textLabel!.text = "HOST: \(item!["REMOTE_HOST"].stringValue), DATE: \(item!["SESSION_CREATE_DATE"].stringValue)"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let clientIdentity = userDefaults.stringForKey("clientIdentity")!
        let clientDigest = userDefaults.stringForKey("clientDigest")!
        let parameters = ["clientIdentity": clientIdentity, "clientDigest": clientDigest]
        
        //self.activityIndicatorView.startAnimating()
        Alamofire.request(.GET, url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let data = JSON(value)["result"]
                    self.data = data
                    print(data)
                }
            case .Failure(let error):
                print(error)
                let alert = UIAlertController(title: "错误", message: "网络错误", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alert, animated: true, completion: { () -> Void in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            //self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
