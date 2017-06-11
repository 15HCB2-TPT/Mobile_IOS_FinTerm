//
//  Expense_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class AddRecord_ViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var view_ghichep: UIView!
    @IBOutlet weak var btn_ghichep: UIButton!
    
    @IBOutlet weak var view_chinhanh: UIView!
    @IBOutlet weak var btn_ghichepnhanh: UIButton!
    
    @IBOutlet weak var v: UIView!
    
    var tc: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Chi'"), sorter: nil)[0] as? Type
    var tt: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Thu'"), sorter: nil)[0] as? Type
    @IBOutlet weak var lblGhiChep: UILabel!
    @IBOutlet weak var lblKhoanChi: UILabel!
    @IBOutlet weak var swtGhiChep: UISwitch!
    @IBOutlet weak var lblKhoanThu: UILabel!
    
    @IBOutlet weak var lblSoTien: UILabel!
    @IBOutlet weak var txt_sotien: UITextField!
    
    var c: Category? = nil
    @IBOutlet weak var lblDanhMuc: UILabel!
    @IBOutlet weak var txt_danhmuc: UITextField!
    
    @IBOutlet weak var lblDienGiai: UILabel!
    @IBOutlet weak var txt_diengiai: UITextField!
    
    var b: BagMoney? = nil
    @IBOutlet weak var lblTaiKhoan: UILabel!
    @IBOutlet weak var txt_taikhoan: UITextField!
    
    let datePicker = UIDatePicker()
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var txt_ngay: UITextField!

    @IBOutlet weak var btn_xong: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borderView(v: view_ghichep)
        borderView(v: view_chinhanh)
        btn_ghichep.setTitle("Danh sách ghi chép", for: .normal)
        btn_ghichepnhanh.setTitle("Ghi chép nhanh", for: .normal)
        
        borderView(v: v)
        lblGhiChep.text = "Ghi chép"
        lblKhoanChi.text = "Khoản chi"
        lblKhoanThu.text = "Khoản thu"
        lblSoTien.text = "Số tiền"
        lblDanhMuc.text = "Danh mục"
        lblDienGiai.text = "Diễn giải"
        lblTaiKhoan.text = "Tài khoản"
        lblNgay.text = "Ngày"
        btn_xong.setTitle("Xong", for: .normal)
        
        txt_danhmuc.delegate = self
        txt_taikhoan.delegate = self
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
    }
    
    @IBAction func btn_ghichep_TouchUpInside(_ sender: Any) {
        pushData(storyboard: "Money", controller: "listRecord", data: nil)
    }
    
    @IBAction func swtGhiChep_ValueChanged(_ sender: Any) {
        c = nil
        txt_danhmuc.text = ""
    }

    @IBAction func btn_xong_TouchUpInside(_ sender: Any) {
        if(b == nil || c == nil) {
            let alert = UIAlertController(title: "Lỗi", message: "Danh mục và Tài khoản không được để trống.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let m: Money = Database.create()
            m.money_type = swtGhiChep.isOn ? tt : tc
            m.money = (txt_sotien.text?.doubleValue)!
            m.money_category = c
            m.reason = txt_diengiai.text
            m.money_bagmoney = b
            m.date = datePicker.date as NSDate
            Database.save()
            
            txt_sotien.text = ""
            txt_danhmuc.text = ""
            txt_diengiai.text = ""
            createDatePicker()
            c = nil
        }
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
