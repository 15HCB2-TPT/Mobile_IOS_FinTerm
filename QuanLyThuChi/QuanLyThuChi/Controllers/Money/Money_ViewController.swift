//
//  Money_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Money_ViewController: UIViewController {


    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var container_Chi: UIView!
    @IBOutlet weak var container_Thu: UIView!
    @IBOutlet weak var container_ChuyenKhoan: UIView!
    @IBOutlet weak var navi: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        //UINavigationBar.appearance().isTranslucent = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        container_Chi.alpha = 0
        container_ChuyenKhoan.alpha = 0
        container_Thu.alpha = 0
    }
    
    @IBAction func segmentedChanged(_ sender: Any) {
        switch segmented.selectedSegmentIndex {
        case 0:
            container_Chi.isHidden = false
            container_Thu.isHidden = true
            container_ChuyenKhoan.isHidden = true
            UIView.animate(withDuration: 0.5, animations: {
                self.container_Chi.alpha = 1
                self.container_Thu.alpha = 0
                self.container_ChuyenKhoan.alpha = 0
            })
        case 1:
            container_Chi.isHidden = true
            container_Thu.isHidden = false
            container_ChuyenKhoan.isHidden = true
            UIView.animate(withDuration: 0.5, animations: {
                self.container_Chi.alpha = 0
                self.container_Thu.alpha = 1
                self.container_ChuyenKhoan.alpha = 0
            })
        case 2:
            container_Chi.isHidden = true
            container_Thu.isHidden = true
            container_ChuyenKhoan.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.container_Chi.alpha = 0
                self.container_Thu.alpha = 0
                self.container_ChuyenKhoan.alpha = 1
            })
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            self.container_Chi.alpha = 1
        })
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
