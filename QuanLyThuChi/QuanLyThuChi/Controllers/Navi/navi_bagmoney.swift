//
//  navi_controller1.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/8/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class navi_bagmoney: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storyboard = UIStoryboard.init(name: "BagMoney", bundle: nil)
        let navi = storyboard.instantiateViewController(withIdentifier: "BagMoney")
        self.pushViewController(navi, animated: false)
    }
}
