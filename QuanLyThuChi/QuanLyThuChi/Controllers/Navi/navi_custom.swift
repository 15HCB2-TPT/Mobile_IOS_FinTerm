//
//  navi_controller2.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/8/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class navi_custom: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storyboard = UIStoryboard.init(name: "Custom", bundle: nil)
        let navi = storyboard.instantiateViewController(withIdentifier: "Custom")
        self.pushViewController(navi, animated: false)

    }
}
