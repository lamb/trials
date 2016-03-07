//
//  ViewController.swift
//  llsfw
//
//  Created by Lamb on 16/3/7.
//  Copyright © 2016年 gm. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var accountTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    let url = "http://192.168.16.85:8080/llsfw-webdemo/api/login"
    
    @IBAction func signin(sender: UIButton) {
        let account = accountTextField.text!
        let password = passwordTextField.text!
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let parameters = ["clientUserName": account, "clientPassword": password]

        self.activityIndicatorView.startAnimating()
        Alamofire.request(.POST, url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let data = JSON(value)["result"]
                    print(data)
                    let clientDigest: String = data["clientDigest"].stringValue
                    let clientIdentity: String = data["clientIdentity"].stringValue
                    userDefaults.setObject(clientDigest, forKey: "clientDigest")
                    userDefaults.setObject(clientIdentity, forKey: "clientIdentity")
                    userDefaults.setObject(account, forKey: "account")
                    userDefaults.synchronize()
                    self.presentViewController()
                }
            case .Failure(let error):
                print(error)
                let alert = UIAlertController(title: "错误", message: "用户名或密码错误", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alert, animated: true, completion: { () -> Void in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    //跳转去首页
    func presentViewController(){
        let onlineViewController = storyboard?.instantiateViewControllerWithIdentifier("OnlineViewController") as! OnlineViewController
        onlineViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(onlineViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let account = userDefaults.stringForKey("account") {
            accountTextField.text = account
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

