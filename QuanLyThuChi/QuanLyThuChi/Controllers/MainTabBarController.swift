//
//  MainTabBarController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabbar()
        // Do any additional setup after loading the view.
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
