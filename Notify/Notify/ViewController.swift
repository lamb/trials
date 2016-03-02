//
//  ViewController.swift
//  Notify
//
//  Created by Lamb on 15/10/27.
//  Copyright © 2015年 Lamb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "drwaAShape:", name: "actionOnePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAMessage:", name: "actionTwoPressed", object: nil)
        
        let dateComp: NSDateComponents = NSDateComponents()
        dateComp.year = 2015
        dateComp.month = 10
        dateComp.day = 28
        dateComp.hour = 18
        dateComp.minute = 017
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        let calender:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        //let date: NSDate = calender.dateFromComponents(dateComp)!
        let date: NSDate = NSDate(timeIntervalSinceNow: 60)
        
        
        let notification: UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, I am a notification!"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    func drwaAShape(notification: NSNotification) {
        let view: UIView = UIView(frame: CGRectMake(10, 10, 100, 100))
        view.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(view)
    }
    
    func showAMessage(notification: NSNotification) {
        let messageVC: UIAlertController = UIAlertController(title: "A Notification Message", message: "Hello there", preferredStyle: UIAlertControllerStyle.Alert)
        messageVC.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(messageVC, animated: true, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

