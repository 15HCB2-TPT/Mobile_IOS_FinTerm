//
//  navi_settings.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/8/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class navi_settings: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
        let navi = storyboard.instantiateViewController(withIdentifier: "Settings")
        self.pushViewController(navi, animated: false)
        
    }
}
