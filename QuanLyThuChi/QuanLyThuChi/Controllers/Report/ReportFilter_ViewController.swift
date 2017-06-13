//
//  ReportFilter_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/7/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class ReportFilter_ViewController: UIViewController {

    //cum btn loai thong ke
    @IBOutlet weak var btn_Thu: CheckBox!
    @IBOutlet weak var btn_Chi: CheckBox!
    @IBOutlet weak var btn_ChuyenKhoan: CheckBox!
    
    //cum btn thoi gian
    @IBOutlet weak var btn_Nam: CheckBox!
    @IBOutlet weak var btn_Thang: CheckBox!
    @IBOutlet weak var btn_TuyChon: CheckBox!
    
    //cum view
    @IBOutlet weak var view_ThongKe: UIView!
    @IBOutlet weak var view_Nam: UIView!
    @IBOutlet weak var view_Thang: UIView!
    @IBOutlet weak var view_TuyChon: UIView!
    
    func loadUI(){
        borderView(v: view_Nam)
        borderView(v: view_Thang)
        borderView(v: view_TuyChon)
        borderView(v: view_ThongKe)
        
        moveUp(view: view_Nam)
        
    }
    
    func moveUp(view: UIView){
        var TopFrame = self.view.frame
        TopFrame.origin.y -= TopFrame.size.height

        self.view.frame = TopFrame
    }
    
    func moveDown(view: UIView){
        var TopFrame = self.view.frame
        TopFrame.origin.y += TopFrame.size.height
        
        self.view.frame = TopFrame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Click Chon loai thong ke
    @IBAction func LoaiThongKeClick(_ sender: Any) {
        if sender as! UIButton == btn_Thu {
            btn_Thu.isChecked = !btn_Thu.isChecked
        }
        if sender as! UIButton == btn_Chi {
            btn_Chi.isChecked = !btn_Chi.isChecked
        }
        if sender as! UIButton == btn_ChuyenKhoan {
            btn_ChuyenKhoan.isChecked = !btn_ChuyenKhoan.isChecked
        }
        if btn_Nam.isChecked || btn_Thang.isChecked || btn_TuyChon.isChecked {
            if btn_Nam.isChecked {
                view_Nam.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 1
                    self.view_Thang.alpha = 0
                    self.view_TuyChon.alpha = 0
                })
            }
            else{
                view_Nam.isHidden = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                })
            }
            if btn_Thang.isChecked {
                view_Thang.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                    self.view_Thang.alpha = 1
                    self.view_TuyChon.alpha = 0
                })
            }
            else{
                view_Thang.isHidden = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Thang.alpha = 0
                })
            }
            if btn_TuyChon.isChecked {
                view_TuyChon.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                    self.view_Thang.alpha = 0
                    self.view_TuyChon.alpha = 1
                })
            }
            else{
                view_TuyChon.isHidden = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_TuyChon.alpha = 0
                })
            }
        }

    }
    
    //Click Chon loai thoi gian
    @IBAction func LoaiThoiGianClick(_ sender: Any) {
        if sender as! UIButton == btn_Nam {
            if btn_Nam.isChecked {
                btn_Nam.isChecked = false
            }else{
                btn_Nam.isChecked = true
                btn_Thang.isChecked = false
                btn_TuyChon.isChecked = false
            }
        }
        
        if sender as! UIButton == btn_Thang {
            if btn_Thang.isChecked {
                btn_Thang.isChecked = false
            }else{
                btn_Nam.isChecked = false
                btn_Thang.isChecked = true
                btn_TuyChon.isChecked = false
            }
        }
        if sender as! UIButton == btn_TuyChon {
            if btn_TuyChon.isChecked {
                btn_TuyChon.isChecked = false
            }else{
                btn_Nam.isChecked = false
                btn_Thang.isChecked = false
                btn_TuyChon.isChecked = true
            }
        }
        
        if btn_Thu.isChecked || btn_Chi.isChecked || btn_ChuyenKhoan.isChecked {
            if btn_Nam.isChecked {
                view_Nam.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 1
                    self.view_Thang.alpha = 0
                    self.view_TuyChon.alpha = 0
                })
            }
            else{
                view_Nam.isHidden = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                })
            }
            if btn_Thang.isChecked {
                view_Thang.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                    self.view_Thang.alpha = 1
                    self.view_TuyChon.alpha = 0
                })
            }
            else{
                view_Thang.isHidden = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Thang.alpha = 0
                })
            }
            if btn_TuyChon.isChecked {
                view_TuyChon.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                    self.view_Thang.alpha = 0
                    self.view_TuyChon.alpha = 1
                })
            }
            else{
                view_TuyChon.isHidden = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_TuyChon.alpha = 0
                })
            }
        }
        
        
    }
    
    //BTN Thong ke click ( ca 3 phan )
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
