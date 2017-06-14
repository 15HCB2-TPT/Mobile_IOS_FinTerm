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
    @IBOutlet weak var v: UIView!
    
    var tc: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Chi'"), sorter: nil)[0] as? Type
    var tt: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Thu'"), sorter: nil)[0] as? Type
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
        loadtext()
        borderView(v: v)
        
        
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
    
    func loadtext(){
        lblKhoanChi.text = "Khoản chi".trans
        lblKhoanThu.text = "Khoản thu".trans
        lblSoTien.text = "Số tiền".trans
        lblDanhMuc.text = "Danh mục".trans
        lblDienGiai.text = "Diễn giải".trans
        lblTaiKhoan.text = "Tài khoản".trans
        lblNgay.text = "Ngày".trans
        btn_xong.setTitle("Xong".trans, for: .normal)
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
        
        txt_ngay.text = "Hôm nay".trans
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
    
    @IBAction func swtGhiChep_ValueChanged(_ sender: Any) {
        c = nil
        txt_danhmuc.text = ""
    }

    @IBAction func btn_xong_TouchUpInside(_ sender: Any) {
        if(b == nil || c == nil) {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Danh mục và Tài khoản không được để trống.".trans, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK".trans, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let m: Money = Database.create()
            m.money_type = swtGhiChep.isOn ? tt : tc
            m.money = (txt_sotien.text?.doubleValue)!
            m.money_category = c
            m.reason = txt_diengiai.text
            m.money_bagmoney = b
            b?.money = swtGhiChep.isOn ? (b?.money)! + m.money : (b?.money)! - m.money
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
