//
//  EditTransfer_ViewController.swift
//  QuanLyThuChi
//
//  Created by Phạm Tú on 6/13/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class EditTransfer_ViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nav_item: UINavigationItem!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var v: UIView!
    
    @IBOutlet weak var lblChuyenKhoan: UILabel!
    @IBOutlet weak var lblSoTien: UILabel!
    @IBOutlet weak var txt_sotien: UITextField!
    
    @IBOutlet weak var lblTuTaiKhoan: UILabel!
    @IBOutlet weak var txt_tutaikhoan: UITextField!
    
    @IBOutlet weak var lblDenTaiKhoan: UILabel!
    @IBOutlet weak var txt_dentaikhoan: UITextField!
    
    @IBOutlet weak var lblDienGiai: UILabel!
    @IBOutlet weak var txt_diengiai: UITextField!
    
    let datePicker = UIDatePicker()
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var txt_ngay: UITextField!
    
    @IBOutlet weak var btn_luu: UIButton!
    @IBOutlet weak var btn_xoa: UIButton!
    
    var ttk: BagMoney? = nil
    var ttk_old: BagMoney!
    var dtk: BagMoney? = nil
    var dtk_old: BagMoney!
    var m_old: Double!
    var mc: Money!
    var mt: Money!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtext()
        
        borderView(v: v)
        
        
        txt_tutaikhoan.delegate = self
        txt_dentaikhoan.delegate = self
        txt_sotien.inputAccessoryView = addDoneButton()
        txt_diengiai.inputAccessoryView = addDoneButton()
        createDatePicker()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadtext(){
        nav_item.title = "Chỉnh sửa".trans
        lblChuyenKhoan.text = "Chuyển khoản".trans
        lblSoTien.text = "Số tiền".trans
        lblTuTaiKhoan.text = "Từ TK".trans
        lblDenTaiKhoan.text = "Đến TK".trans
        lblDienGiai.text = "Diễn giải".trans
        lblNgay.text = "Ngày".trans
        
        btn_luu.setTitle("Lưu".trans, for: .normal)
        btn_xoa.setTitle("Xoá".trans, for: .normal)
    }
    
    func keyboardWillShow(_ notification: Notification){
        let info = notification.userInfo
        let keyboard = (info?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let contentinset = UIEdgeInsetsMake(0, 0, keyboard.height - 44, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }
    
    func keyboardWillHide(_ notification: Notification){
        let contentinset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }
    
    func createDatePicker() {
        //datePicker la bien toan cuc
        //format date
        datePicker.datePickerMode = .dateAndTime
        
        //toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([flexBarButton,doneButton],animated:false)
        
        txt_ngay.text = "Hôm nay"
        txt_ngay.inputAccessoryView = toolbar
        txt_ngay.inputView = datePicker
    }
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        txt_ngay.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func btndoneClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == txt_tutaikhoan) {
            pushData(storyboard: "Money", controller: "selectBagMoney", data: 21)
        }
        if(textField == txt_dentaikhoan) {
            pushData(storyboard: "Money", controller: "selectBagMoney", data: 22)
        }
        return false
    }
    
    override func uiPassedData(data: Any?, identity: Int) {
        if (identity == 21) {
            let tk = data as! BagMoney
            ttk = tk
            txt_tutaikhoan.text = ttk?.name
        }
        if (identity == 22) {
            let tk = data as! BagMoney
            dtk = tk
            txt_dentaikhoan.text = dtk?.name
        }
        if (identity == 3) {
            mc = data as! Money
            if(mc != nil) {
                txt_sotien.text = String(format: "%.0f", mc.money)
                m_old = mc.money
                ttk = mc.money_bagmoney!
                ttk_old = mc.money_bagmoney!
                txt_tutaikhoan.text = ttk!.name!
                dtk = mc.transfer!.money_bagmoney!
                dtk_old = mc.transfer!.money_bagmoney!
                txt_dentaikhoan.text = dtk!.name!
                txt_diengiai.text = mc.reason!
                createDatePicker()
                datePicker.setDate(mc.date! as Date, animated: false)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .short
                txt_ngay.text = dateFormatter.string(from: datePicker.date)
            }
        }
    }
    
    @IBAction func btn_back_TouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_luu_TouchUpInside(_ sender: Any) {
        if(ttk == nil || dtk == nil) {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Các tài khoản không được để trống.".trans, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Hiểu".trans, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if(ttk == dtk) {
                let alert = UIAlertController(title: "Lỗi".trans, message: "Không thể chuyển trong cùng tài khoản.".trans, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Hiểu".trans, style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                mc.money = (txt_sotien.text?.doubleValue)!
                mc.reason = txt_diengiai.text
                mc.money_bagmoney = ttk
                ttk_old.money = ttk_old.money + m_old
                ttk?.money = (ttk?.money)! - mc.money
                mc.date = datePicker.date as NSDate
                
                mt = mc.transfer!
                mt.money = (txt_sotien.text?.doubleValue)!
                mt.reason = txt_diengiai.text
                mt.money_bagmoney = dtk
                dtk_old.money = dtk_old.money - m_old
                dtk?.money = (dtk?.money)! + mc.money
                mt.date = datePicker.date as NSDate
                Database.save()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func btn_xoa_TouchUpInside(_ sender: Any) {
        ttk_old.money = ttk_old.money + m_old
        dtk_old.money = dtk_old.money - m_old
        Database.delete(object: mc.transfer!)
        Database.delete(object: mc)
        Database.save()
        self.navigationController?.popViewController(animated: true)
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
