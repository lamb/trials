//
//  ViewController1.swift
//  chevrolet
//
//  Created by Lamb on 16/3/2.
//  Copyright © 2016年 gm. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBAction func click(sender: UIButton) {
        let alert = UIAlertController(title: "title1", message: "this is 1", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
