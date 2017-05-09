//
//  Expense_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Expense_ViewController: UIViewController {

    @IBOutlet weak var v: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // border radius
        v.layer.cornerRadius = 10
        
        // border
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.layer.borderWidth = 1
        
        // drop shadow
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowRadius = 3.0
        v.layer.shadowOffset = CGSize(width: 2, height: 2)
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
