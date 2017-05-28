//
//  Expense_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Transfer_ViewController: UIViewController {

    @IBOutlet weak var vfrom: UIView!
    @IBOutlet weak var vto: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //load UI
    func loadUI(){
        // border radius
        vfrom.layer.cornerRadius = 10
        
        // border
        vfrom.layer.borderColor = UIColor.lightGray.cgColor
        vfrom.layer.borderWidth = 1
        
        // drop shadow
        vfrom.layer.shadowColor = UIColor.black.cgColor
        vfrom.layer.shadowOpacity = 0.8
        vfrom.layer.shadowRadius = 3.0
        vfrom.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        // Do any additional setup after loading the view.
        
        vto.layer.cornerRadius = 10
        
        // border
        vto.layer.borderColor = UIColor.lightGray.cgColor
        vto.layer.borderWidth = 1
        
        // drop shadow
        vto.layer.shadowColor = UIColor.black.cgColor
        vto.layer.shadowOpacity = 0.8
        vto.layer.shadowRadius = 3.0
        vto.layer.shadowOffset = CGSize(width: 2, height: 2)


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
