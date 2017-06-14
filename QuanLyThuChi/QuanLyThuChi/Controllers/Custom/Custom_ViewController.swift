//
//  Custom_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

protocol SelectedCategory : class{
    func selectedcategory(category: Category)
}
class Custom_ViewController: UIViewController,SelectedCategory,UIPickerViewDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var btn_danhmucthuchi: UIButton!
    @IBOutlet weak var btn_danhsachcustom: UIButton!
    @IBOutlet weak var lbl_thietlap: UILabel!
    @IBOutlet weak var lbl_thietlapnhanh: UILabel!
    @IBOutlet weak var lbl_loaiphi: UILabel!
    @IBOutlet weak var btn_danhmuc: UIButton!
    @IBOutlet weak var lbl_tuihaydung: UILabel!
    @IBOutlet weak var lbl_money: UILabel!
    @IBOutlet weak var lbl_runtime: UILabel!
    @IBOutlet weak var lbl_loop: UILabel!
    @IBOutlet weak var btn_ThemMoi: UIButton!

    @IBOutlet weak var txt_type: RightIcon_TextField!
    @IBOutlet weak var view_looptime: UIView!
    @IBOutlet weak var txt_looptime: UITextField!
    @IBOutlet weak var lbl_typeloop: UILabel!
    @IBOutlet weak var btn_Ngay: CheckBox!
    @IBOutlet weak var btn_Thang: CheckBox!
    @IBOutlet weak var btn_Nam: CheckBox!
    @IBOutlet weak var txt_ngaychay: RightIcon_TextField!
    @IBOutlet weak var txt_tuichi: UITextField!
    @IBOutlet weak var txt_tienchi: UITextField!
    @IBOutlet weak var lbl_category: UILabel!
    
    var datePicker = UIDatePicker()
    var categoryofbagmoney:Category? = nil
    var pickerview_type = UIPickerView()
    var pickerview_thu = UIPickerView()
    var pickerview_chi = UIPickerView()
    var bagmoneyselected:BagMoney? = nil
    var listbagmoney:[BagMoney] = Database.select()
    var listtype:[Type] = Database.select()
    @IBOutlet weak var view_danhmucthuchi: UIView!
    @IBOutlet weak var view_thietlapnhanh: UIView!
    @IBOutlet weak var view_chi: UIView!
    @IBOutlet weak var view_btndanhmucchi: UIView!
    @IBOutlet weak var scrollview: UIScrollView!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtext()
        dropshadowView(v: view_btndanhmucchi)
        borderView(v: view_danhmucthuchi)
        borderView(v: view_thietlapnhanh)
        borderView(v: view_chi)
        
        //
        createDatePicker()
        txt_looptime.inputAccessoryView = addDoneButton()
        txt_tuichi.inputAccessoryView = addDoneButton()
        txt_type.inputAccessoryView = addDoneButton()
        txt_tienchi.inputAccessoryView = addDoneButton()
        
        pickerview_thu.delegate = self
        pickerview_chi.delegate = self
        pickerview_type.delegate = self
        txt_tuichi.inputView = pickerview_chi
        txt_type.inputView = pickerview_type
        if listbagmoney.count>0 {
            txt_tuichi.text = listbagmoney[0].name
            txt_type.text = listtype[0].name
            bagmoneyselected = listbagmoney[0]
        }else{
            txt_tuichi.delegate = self
            txt_type.delegate = self
            txt_looptime.delegate = self
        }
        //
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadtext(){
        self.title = "Thiết lập".trans
        btn_danhmucthuchi.setTitle("Danh mục thu chi".trans, for: .normal)
        btn_danhsachcustom.setTitle("Danh sách thiết lập nhanh".trans, for: .normal)
        lbl_thietlap.text = "Thiết lập".trans
        lbl_thietlapnhanh.text = "Thêm mới thiết lập nhanh".trans
        lbl_loaiphi.text = "Loại phí".trans
        btn_danhmuc.setTitle("Danh mục".trans, for: .normal)
        lbl_tuihaydung.text = "Tài khoản".trans
        lbl_money.text = "Số tiền".trans
        lbl_runtime.text = "Băt đầu từ".trans
        lbl_loop.text = "Lặp".trans
        btn_ThemMoi.setTitle("Thêm mới thiết lập nhanh".trans, for: .normal)

        txt_type.placeholder = "Thu/Chi".trans
        btn_Ngay.setTitle("Ngày".trans, for: .normal)
        btn_Thang.setTitle("Tháng".trans, for: .normal)
        btn_Nam.setTitle("Năm".trans, for: .normal)
        txt_ngaychay.placeholder = "Ngày chạy".trans
        txt_tuichi.placeholder = "Tài khoản".trans
        txt_tienchi.placeholder = "Số tiền".trans
        lbl_category.text = "Danh mục".trans
    }
    
    func createDatePicker() {
        //datePicker la bien toan cuc
        //format date
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Xong".trans, style: .plain, target: self, action: #selector(donePressed_datepicker))
        toolbar.setItems([flexBarButton,doneBarButton],animated:false)
        
        txt_ngaychay.text = "Hôm nay".trans
        txt_ngaychay.inputAccessoryView = toolbar
        txt_ngaychay.inputView = datePicker
    }
    
    func donePressed_datepicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy".trans
        dateFormatter.dateStyle = .short
        
        txt_ngaychay.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let alert = UIAlertController(title: "Thông báo".trans, message: "Bạn chưa có túi tiền nào, hãy thêm túi tiền mới trước!".trans, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return false
    }
    
    
    //pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerview_type {
            return listtype.count
        }else{
            return listbagmoney.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerview_type {
            return listtype[row].name
        }else{
            return listbagmoney[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerview_type {
            lbl_category.text = ""
            categoryofbagmoney = nil
            txt_type.text = listtype[row].name
        }else{
            if listbagmoney.count <= 0 {
                self.txt_tuichi.text = ""
            }
            else{
                    self.txt_tuichi.text = listbagmoney[row].name
                }
            }
        }
    //
    
    func keyboardWillShow(_ notification: Notification){
        let info = notification.userInfo
        let keyboard = (info?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let contentinset = UIEdgeInsetsMake(0, 0, keyboard.height-44, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }
    
    func keyboardWillHide(_ notification: Notification){
        let contentinset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }


    func selectedcategory(category: Category) {
        categoryofbagmoney = category
        lbl_category.text = category.name!
    }
    
    @IBAction func DanhMucClick(_ sender: Any) {
        if txt_type.text == "Thu" {
            let vc = UIStoryboard.init(name: "Custom", bundle: nil).instantiateViewController(withIdentifier: "chooseinclude") as! ChooseInclude_ViewController
            vc.customdelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = UIStoryboard.init(name: "Custom", bundle: nil).instantiateViewController(withIdentifier: "chooseexpense") as! ChooseExpense_ViewController
            vc.customdelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func CheckChange(_ sender: Any) {
        view_looptime.isHidden = false
        if !btn_Ngay.isChecked || !btn_Thang.isChecked || !btn_Nam.isChecked {
            if sender as! CheckBox == btn_Ngay {
                if btn_Ngay.isChecked {
                    btn_Ngay.isChecked = false
                    view_looptime.isHidden = true
                    return
                }
                else{
                    btn_Ngay.isChecked = true
                    btn_Thang.isChecked = false
                    btn_Nam.isChecked = false
                    lbl_typeloop.text = "Ngày".trans
                }
            }
            if sender as! CheckBox == btn_Thang {
                if btn_Thang.isChecked {
                    btn_Thang.isChecked = false
                    view_looptime.isHidden = true
                    return
                }
                else{
                    btn_Ngay.isChecked = false
                    btn_Thang.isChecked = true
                    btn_Nam.isChecked = false
                    lbl_typeloop.text = "Tháng".trans
                }
            }
            if sender as! CheckBox == btn_Nam {
                if btn_Nam.isChecked {
                    btn_Nam.isChecked = false
                    view_looptime.isHidden = true
                    return
                }
                else{
                    btn_Ngay.isChecked = false
                    btn_Thang.isChecked = false
                    btn_Nam.isChecked = true
                    lbl_typeloop.text = "Năm".trans
                }
            }
        }
    }

    @IBAction func ThemThietLapNhanh(_ sender: Any) {
        if lbl_category.text == "" {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Danh mục chưa được chọn. Hãy chọn lại.".trans, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if txt_tuichi.text == "" {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Tài khoản không hợp lệ.".trans, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if Double(txt_tienchi.text!) == nil {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Số tiền có sẵn trong túi không đúng".trans, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            return
        }
        
        let alert = UIAlertController(title: "Đặt tên thiết lập nhanh.".trans, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Tên thiết lập".trans
        }
        alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: { [weak alert] (_) in
            var temp = [Common]()
            if self.txt_type.text == "Thu"{
                temp = Database.select(entityName: "Common", predicater: NSPredicate(format: "name = %@ AND category.category_type.name == 'Thu'",(alert?.textFields![0].text)!), sorter: nil) as! [Common]
            }else{
                temp = Database.select(entityName: "Common", predicater: NSPredicate(format: "name = %@ AND category.category_type.name == 'Chi'",(alert?.textFields![0].text)!), sorter: nil) as! [Common]
            }
            
            if temp.count <= 0 && alert?.textFields![0].text != ""{
                
                let common:Common = Database.create()
                common.category = self.categoryofbagmoney
                common.bagmoney = self.bagmoneyselected
                common.money = Double(self.txt_tienchi.text!)!
                common.name = alert?.textFields![0].text
                if self.btn_Ngay.isChecked {
                    common.loopday = true
                }
                if self.btn_Thang.isChecked {
                    common.loopmonth = true
                }
                if self.btn_Nam.isChecked {
                    common.loopyear = true
                }
                common.looptime = Int32(self.txt_looptime.text!)!
                common.lastadd = self.datePicker.date as! NSDate
                Database.save()
                
                let alert_notice = UIAlertController(title: "Thông báo".trans, message: "Thêm thành công!".trans, preferredStyle: .alert)
                alert_notice.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
                self.present(alert_notice, animated: true, completion: nil)
                return
            }
            else{
                if alert?.textFields![0].text == ""{
                    let alert_notice = UIAlertController(title: "Lỗi".trans, message: "Tên thiết lập nhanh không được để trống!".trans, preferredStyle: .alert)
                    alert_notice.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
                    self.present(alert_notice, animated: true, completion: nil)
                    return
                }
                else{
                    let alert_notice = UIAlertController(title: "Lỗi".trans, message: "Tên thiết lập đã tồn tại, hãy đặt tên khác.".trans, preferredStyle: .alert)
                    alert_notice.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
                    self.present(alert_notice, animated: true, completion: nil)
                    return
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Hủy".trans, style: .default, handler: {[weak alert] (_) in
            alert?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

