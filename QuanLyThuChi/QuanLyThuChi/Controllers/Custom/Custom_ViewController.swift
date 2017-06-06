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

    @IBOutlet weak var txt_type: RightIcon_TextField!
    @IBOutlet weak var view_looptime: UIView!
    @IBOutlet weak var txt_looptime: UITextField!
    @IBOutlet weak var lbl_typeloop: UILabel!
    @IBOutlet weak var btn_Ngay: CheckBox!
    @IBOutlet weak var btn_Thang: CheckBox!
    @IBOutlet weak var btn_Nam: CheckBox!
    
    @IBOutlet weak var lbl_category: UILabel!
    var categorythu:Category? = nil
    var categorychi:Category? = nil
    var pickerview_type = UIPickerView()
    var pickerview_thu = UIPickerView()
    var pickerview_chi = UIPickerView()
    var bagmoneyselected_thu:BagMoney? = nil
    var bagmoneyselected_chi:BagMoney? = nil
    var listbagmoney:[BagMoney] = Database.select()
    var listtype:[Type] = Database.select()
    @IBOutlet weak var view_danhmucthuchi: UIView!
    @IBOutlet weak var view_thietlapnhanh: UIView!
    @IBOutlet weak var view_chi: UIView!
    @IBOutlet weak var view_btndanhmucchi: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var txt_tuichi: UITextField!
    @IBOutlet weak var txt_tienchi: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropshadowView(v: view_btndanhmucchi)
        borderView(v: view_danhmucthuchi)
        borderView(v: view_thietlapnhanh)
        borderView(v: view_chi)
        
        //
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
            bagmoneyselected_thu = listbagmoney[0]
            bagmoneyselected_chi = listbagmoney[0]
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa có túi tiền nào, hãy thêm túi tiền mới trước!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
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
        categorythu = category
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
                    lbl_typeloop.text = "Ngày"
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
                    lbl_typeloop.text = "Tháng"
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
                    lbl_typeloop.text = "Năm"
                }
            }
        }
    }

    @IBAction func ThemThietLapNhanh(_ sender: Any) {
        if lbl_category.text == "" {
            let alert = UIAlertController(title: "Lỗi", message: "Danh mục chưa được chọn. Hãy chọn lại.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if txt_tuichi.text == "" {
            let alert = UIAlertController(title: "Lỗi", message: "Túi chi ko hợp lệ!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if Double(txt_tienchi.text!) == nil {
            let alert = UIAlertController(title: "Lỗi", message: "Số tiền có sẵn trong túi không đúng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            return
        }
        
        let alert = UIAlertController(title: "Đặt tên chi nhanh", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Tên chi nhanh"
        }
        alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { [weak alert] (_) in
            let temp:[Common] = Database.select(entityName: "Common", predicater: NSPredicate(format: "name = %@ AND category.category_type.name == 'Chi'",(alert?.textFields![0].text)!), sorter: nil) as! [Common]
            if temp.count <= 0 && alert?.textFields![0].text != ""{
                
                let common:Common = Database.create()
                common.category = self.categorychi
                common.bagmoney = self.bagmoneyselected_chi
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
                Database.save()
                
                let alert_notice = UIAlertController(title: "Thông báo", message: "Thêm thành công!", preferredStyle: .alert)
                alert_notice.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                self.present(alert_notice, animated: true, completion: nil)
                return
            }
            else{
                if alert?.textFields![0].text == ""{
                    let alert_notice = UIAlertController(title: "Lỗi", message: "Tên chi nhanh không được để trống!", preferredStyle: .alert)
                    alert_notice.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                    self.present(alert_notice, animated: true, completion: nil)
                    return
                }
                else{
                    let alert_notice = UIAlertController(title: "Lỗi", message: "Tên chi nhanh đã tồn tại, hãy đặt tên khác.", preferredStyle: .alert)
                    alert_notice.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                    self.present(alert_notice, animated: true, completion: nil)
                    return
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Hủy", style: .default, handler: {[weak alert] (_) in
            alert?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

