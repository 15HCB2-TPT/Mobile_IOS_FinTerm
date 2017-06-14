//
//  Money_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Money_ViewController: UIViewController,UITabBarControllerDelegate {
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var container_GhiChep: UIView!
    @IBOutlet weak var container_ChuyenKhoan: UIView!
    @IBOutlet weak var view_dsghichep: UIView!
    @IBOutlet weak var btn_dsghichep: UIButton!
    @IBOutlet weak var view_ghichepnhanh: UIView!
    @IBOutlet weak var btn_ghichepnhanh: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ghi chép".trans
        borderView(v: view_dsghichep)
        btn_dsghichep.setTitle("Danh sách ghi chép", for: .normal)
        borderView(v: view_ghichepnhanh)
        btn_ghichepnhanh.setTitle("Ghi chép nhanh", for: .normal)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedChanged(_ sender: Any) {
        switch segmented.selectedSegmentIndex {
        case 0:
            container_GhiChep.isHidden = false
            container_ChuyenKhoan.isHidden = true
            break
        case 1:
            container_GhiChep.isHidden = true
            container_ChuyenKhoan.isHidden = false
            break
        default:
            break
        }
    }
    
    @IBAction func btn_dsghichep_TouchUpInside(_ sender: Any) {
        pushData(storyboard: "Money", controller: "listRecord", data: nil)
    }
    
    @IBAction func btn_ghichepnhanh_TouchUpInside(_ sender: Any) {
        
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
