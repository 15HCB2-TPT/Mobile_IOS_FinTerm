//
//  Custom_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Custom_ViewController: UIViewController {

    @IBOutlet weak var view_thietlapnhanh: UIView!
    @IBOutlet weak var view_chi: UIView!
    @IBOutlet weak var view_thu: UIView!
    @IBOutlet weak var view_btndanhmucchi: UIView!
    @IBOutlet weak var view_btndanhmucthu: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        borderView(v: view_thietlapnhanh)
        borderView(v: view_chi)
        borderView(v: view_thu)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
