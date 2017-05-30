//
//  Expense_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class AddRecord_ViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var view_ghichep: UIView!
    @IBOutlet weak var btn_ghichep: UIButton!
    
    @IBOutlet weak var view_chinhanh: UIView!
    @IBOutlet weak var btn_ghichepnhanh: UIButton!
    
    @IBOutlet weak var v: UIView!
    
    @IBOutlet weak var lblKhoanChi: UILabel!
    @IBOutlet weak var swtGhiChep: UISwitch!
    @IBOutlet weak var lblKhoanThu: UILabel!
    
    @IBOutlet weak var lblSoTien: UILabel!
    @IBOutlet weak var txt_sotien: UITextField!
    
    @IBOutlet weak var lblDanhMuc: UILabel!
    @IBOutlet weak var txt_danhmuc: UITextField!
    
    @IBOutlet weak var lblTaiKhoan: UILabel!
    @IBOutlet weak var txt_taikhoan: UITextField!
    
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var txt_ngay: UITextField!
    
    @IBOutlet weak var lblDienGiai: UILabel!
    @IBOutlet weak var txt_diengiai: UITextField!
    
    
    
    
    
    
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        borderView(v: view_ghichep)
        borderView(v: view_chinhanh)
        btn_ghichep.setTitle("Danh sách ghi chép", for: .normal)
        btn_ghichepnhanh.setTitle("Ghi chép nhanh", for: .normal)
        
        borderView(v: v)
        lblKhoanChi.text = "Khoản chi"
        lblKhoanThu.text = "Khoản thu"
        lblSoTien.text = "Số tiền"
        lblDanhMuc.text = "Danh mục"
        lblTaiKhoan.text = "Tài khoản"
        lblNgay.text = "Ngày"
        lblDienGiai.text = "Diễn giải"
        
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

    func createDatePicker(){
        //datePicker la bien toan cuc
        //format date
        datePicker.datePickerMode = .date
        
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
    
    func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        txt_ngay.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    

    @IBAction func btndoneClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
