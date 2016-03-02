//
//  ViewController.swift
//  chevrolet
//
//  Created by Lamb on 16/2/22.
//  Copyright © 2016年 gm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var subnavView: UIView!
    @IBOutlet var shortcutView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    private var viewController1:ViewController1!
    private var viewController2:ViewController2!
    private var viewController3:ViewController3!
    
    @IBAction func label(sender: UIButton) {
        print("label")
    }
    
    @IBAction func menu(sender: UIButton) {
        print("menu")
    }
    
    //实现UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16;
    }
    
    //实现UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! CollectionViewCell
        // 从界面查找到控件元素并设置属性
        cell.imageView.image = UIImage(named: "CollectionCell\(indexPath.row + 1)")
        return cell;
    }
    
    //实现UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let subviews = subnavView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
        UIView.beginAnimations("context", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseOut)
        UIView.setAnimationTransition(.FlipFromRight, forView: subnavView, cache: true)
        
        let button1 = UIButton(frame:CGRectMake(10, 5, 100, 30))
        button1.setTitle("按钮1", forState:UIControlState.Normal)
        button1.setTitleColor(UIColor.blackColor(),forState: .Normal)
        button1.addTarget(self,action:Selector("tapped:"),forControlEvents:.TouchUpInside)
        subnavView.addSubview(button1)
        
        let button2 = UIButton(frame:CGRectMake(120, 5, 100, 30))
        button2.setTitle("按钮2", forState:UIControlState.Normal)
        button2.setTitleColor(UIColor.blackColor(),forState: .Normal)
        button2.addTarget(self,action:Selector("tapped:"),forControlEvents:.TouchUpInside)
        subnavView.addSubview(button2)
        UIView.commitAnimations()
    }
    
    func tapped(button: UIButton) {
        let subviews = shortcutView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
        UIView.beginAnimations("context", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseOut)
        UIView.setAnimationTransition(.FlipFromLeft, forView: shortcutView, cache: true)

        let button01 = UIButton(frame:CGRectMake(10, 5, 100, 30))
        button01.setTitle("按钮01", forState:UIControlState.Normal)
        button01.setTitleColor(UIColor.blackColor(),forState: .Normal)
        button01.addTarget(self,action:Selector("showContent:"),forControlEvents:.TouchUpInside)
        shortcutView.addSubview(button01)
        
        let button02 = UIButton(frame:CGRectMake(120, 5, 100, 30))
        button02.setTitle("按钮02", forState:UIControlState.Normal)
        button02.setTitleColor(UIColor.blackColor(),forState: .Normal)
        button02.addTarget(self,action:Selector("showContent:"),forControlEvents:.TouchUpInside)
        shortcutView.addSubview(button02)
        
        let button03 = UIButton(frame:CGRectMake(230, 5, 100, 30))
        button03.setTitle("按钮03", forState:UIControlState.Normal)
        button03.setTitleColor(UIColor.blackColor(),forState: .Normal)
        button03.addTarget(self,action:Selector("showContent:"),forControlEvents:.TouchUpInside)
        shortcutView.addSubview(button03)
        UIView.commitAnimations()
    }
    
    func showContent(button: UIButton) {
        if(button.titleForState(.Normal) == "按钮01"){
            viewController1 = storyboard?.instantiateViewControllerWithIdentifier("ViewController1") as! ViewController1
            //self.addChildViewController(viewController1)
            addSubview(contentView, viewController: viewController1)
        }
        if(button.titleForState(.Normal) == "按钮02"){
            viewController2 = storyboard?.instantiateViewControllerWithIdentifier("ViewController2") as! ViewController2
            addSubview(contentView, viewController: viewController2)
        }
        if(button.titleForState(.Normal) == "按钮03"){
            viewController3 = storyboard?.instantiateViewControllerWithIdentifier("ViewController3") as! ViewController3
            addSubview(contentView, viewController: viewController3)
        }
    }
    
    func addSubview(view: UIView,viewController: UIViewController){
        let subviews = view.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
        UIView.beginAnimations("context", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        UIView.setAnimationTransition(.CurlUp, forView: view, cache: true)
        view.addSubview(viewController.view)
        viewController.view.frame = CGRectMake(0, 0, view.frame.width - 0, view.frame.height - 0)
        UIView.commitAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

