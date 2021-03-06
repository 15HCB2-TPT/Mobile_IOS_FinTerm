//
//  EditRecord_ViewController.swift
//  QuanLyThuChi
//
//  Created by Phạm Tú on 6/10/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class EditRecord_ViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nav_item: UINavigationItem!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var v: UIView!
    
    var tc: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Chi'"), sorter: nil)[0] as? Type
    var tt: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Thu'"), sorter: nil)[0] as? Type
    @IBOutlet weak var lblGhiChep: UILabel!
    @IBOutlet weak var lblKhoanChi: UILabel!
    @IBOutlet weak var swtGhiChep: UISwitch!
    @IBOutlet weak var lblKhoanThu: UILabel!
    
    @IBOutlet weak var lblSoTien: UILabel!
    @IBOutlet weak var txt_sotien: UITextField!
    
    var c: Category!
    @IBOutlet weak var lblDanhMuc: UILabel!
    @IBOutlet weak var txt_danhmuc: UITextField!
    
    @IBOutlet weak var lblDienGiai: UILabel!
    @IBOutlet weak var txt_diengiai: UITextField!
    
    var b: BagMoney!
    @IBOutlet weak var lblTaiKhoan: UILabel!
    @IBOutlet weak var txt_taikhoan: UITextField!
    
    let datePicker = UIDatePicker()
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var txt_ngay: UITextField!
    
    @IBOutlet weak var btn_xong: UIButton!
    @IBOutlet weak var btn_xoa: UIButton!
    
    var m_old: Money!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtext()
        borderView(v: v)
        
        txt_danhmuc.delegate = self
        txt_taikhoan.delegate = self
        txt_sotien.inputAccessoryView = addDoneButton()
        txt_diengiai.inputAccessoryView = addDoneButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func loadtext(){
        nav_item.title = "Chỉnh sửa".trans
        lblGhiChep.text = "Ghi chép".trans
        
        lblKhoanChi.text = "Khoản chi".trans
        lblKhoanThu.text = "Khoản thu".trans
        lblSoTien.text = "Số tiền".trans
        lblDanhMuc.text = "Danh mục".trans
        lblDienGiai.text = "Diễn giải".trans
        lblTaiKhoan.text = "Tài khoản".trans
        lblNgay.text = "Ngày".trans
        
        btn_xong.setTitle("Lưu".trans, for: .normal)
        btn_xoa.setTitle("Xoá".trans, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if(textField == txt_danhmuc) {
            pushData(storyboard: "Money", controller: "selectCategory", data: swtGhiChep.isOn ? "Thu" : "Chi")
        }
        if(textField == txt_taikhoan) {
            pushData(storyboard: "Money", controller: "selectBagMoney", data: nil)
        }
        return false
    }
    
    override func uiPassedData(data: Any?, identity: Int) {
        if (identity == 1) {
            let dm = data as! Category
            c = dm
            txt_danhmuc.text = c?.name
        }
        
        if (identity == 2) {
            let tk = data as! BagMoney
            b = tk
            txt_taikhoan.text = b?.name
        }
        
        if (identity == 3) {
            m_old = data as! Money
            if(m_old != nil) {
                swtGhiChep.setOn(m_old.money_type!.name! == "Thu", animated: false)
                txt_sotien.text = String(format: "%.0f", m_old.money)
                c = m_old.money_category!
                txt_danhmuc.text = m_old.money_category!.name!
                txt_diengiai.text = m_old.reason!
                b = m_old.money_bagmoney!
                txt_taikhoan.text = m_old.money_bagmoney!.name!
                createDatePicker()
                datePicker.setDate(m_old.date! as Date, animated: false)
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
    
    @IBAction func swtGhiChep_ValueChanged(_ sender: Any) {
        c = nil
        txt_danhmuc.text = ""
    }
    
    @IBAction func btn_xong_TouchUpInside(_ sender: Any) {
        if(b == nil || c == nil) {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Danh mục và Tài khoản không được để trống.".trans, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Hiểu".trans, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if(m_old.money_type!.name! == "Chi") {
                m_old.money_bagmoney?.money = (m_old.money_bagmoney?.money)! + m_old.money
            }
            if(m_old.money_type!.name! == "Thu") {
                m_old.money_bagmoney?.money = (m_old.money_bagmoney?.money)! - m_old.money
            }
            Database.save()
            Database.delete(object: m_old)
            Database.save()
            
            let mn: Money = Database.create()
            mn.money_type = swtGhiChep.isOn ? tt : tc
            mn.money = (txt_sotien.text?.doubleValue)!
            mn.money_category = c
            mn.reason = txt_diengiai.text
            mn.money_bagmoney = b
            b?.money = swtGhiChep.isOn ? (b?.money)! + mn.money : (b?.money)! - mn.money
            mn.date = datePicker.date as NSDate
            Database.save()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btn_xoa_TouchUpInside(_ sender: Any) {
        if(m_old.money_type!.name! == "Chi") {
            m_old.money_bagmoney?.money = (m_old.money_bagmoney?.money)! + m_old.money
        }
        if(m_old.money_type!.name! == "Thu") {
            m_old.money_bagmoney?.money = (m_old.money_bagmoney?.money)! - m_old.money
        }
        Database.save()
        Database.delete(object: m_old)
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
