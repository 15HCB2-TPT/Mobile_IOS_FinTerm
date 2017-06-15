//
//  MainTabBarController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var previousview : UITabBarItem!
    var count = 0
    
    @IBOutlet weak var tabbar: UITabBar!
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Translater.AddForm(form: self)
        for item in tabbar.items! {
            titles.append(item.title!)
            do {
                try item.title = item.title?.trans
            } catch  {
                
            }
        }

        
        customTabbar()
        // Do any additional setup after loading the view.
    }
    
    override func transReload() {
        for i in 0 ..< tabbar.items!.count {
            tabbar.items?[i].title = titles[i].trans
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func customTabbar(){

        tabbar.layer.borderWidth = 1
        tabbar.layer.borderColor = UIColor.lightGray.cgColor
        tabbar.clipsToBounds = true
        let numberOfItems = CGFloat(tabbar.items!.count)
        let tabBarItemSize = CGSize(width: tabbar.frame.width / numberOfItems, height: tabbar.frame.height)
        let image = UIImage.imageWithColor(color: UIColor(red: 0.9, green: 0.9 , blue: 0.9, alpha: 0.5), size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets.zero)
        tabbar.selectionIndicatorImage = image
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
