//
//  ViewController.swift
//  Octopus
//
//  Created by Lamb on 15/10/19.
//  Copyright © 2015年 Lamb. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var text: UITextView!
    
    @IBAction func send(sender: UIButton) {
        if let textString = text.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) {
            if !textString.isEmpty{
                print("send \(textString)")
                prepare(textString)
            }
        }
    }
    
    //条之间是|分隔，内容号码是-分隔
    func prepare(text: String) {
        let msgs: [String] = text.componentsSeparatedByString("|")
        for msg in msgs {
            let chips: [String] = msg.componentsSeparatedByString("-")
            if chips.count == 2 {
                let number = chips[0];
                let content = chips[1];
                print("number:\(number),content:\(content)")
                sendSMS(number, content: content)
            }
        }
    }
    
    func sendSMS(number: String, content: String) {
        if MFMessageComposeViewController.canSendText(){
            let controller = MFMessageComposeViewController()
            controller.body = content
            controller.recipients = [number]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        } else {
            let alert = UIAlertView(title: "提示信息", message: "本设备不能发短信", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        switch result.rawValue{
        case MessageComposeResultSent.rawValue:
            print("短信已发送")
        case MessageComposeResultCancelled.rawValue:
            print("短信已取消")
        case MessageComposeResultFailed.rawValue:
            print("短信发送失败")
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
