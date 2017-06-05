//
//  Custom_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

protocol SelectedCategory : class{
    func selectedcategoryfromThu(category: Category)
    func selectedcategoryfromChi(category: Category)
}
class Custom_ViewController: UIViewController,SelectedCategory,UIPickerViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var lbl_categorythu: UILabel!
    @IBOutlet weak var lbl_categorychi: UILabel!
    var categorythu:Category? = nil
    var categorychi:Category? = nil
    var pickerview_thu = UIPickerView()
    var pickerview_chi = UIPickerView()
    var bagmoneyselected_thu:BagMoney? = nil
    var bagmoneyselected_chi:BagMoney? = nil
    var listbagmoney:[BagMoney] = Database.select()
    @IBOutlet weak var view_danhmucthuchi: UIView!
    @IBOutlet weak var view_thietlapnhanh: UIView!
    @IBOutlet weak var view_chi: UIView!
    @IBOutlet weak var view_thu: UIView!
    @IBOutlet weak var view_btndanhmucchi: UIView!
    @IBOutlet weak var view_btndanhmucthu: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var txt_tuichi: UITextField!
    @IBOutlet weak var txt_tienchi: UITextField!
    @IBOutlet weak var txt_tuithu: UITextField!
    @IBOutlet weak var txt_tienthu: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borderView(v: view_danhmucthuchi)
        borderView(v: view_thietlapnhanh)
        borderView(v: view_chi)
        borderView(v: view_thu)
        
        //
        txt_tienchi.inputAccessoryView = addDoneButton()
        txt_tuithu.inputAccessoryView = addDoneButton()
        customtoolbar()
        pickerview_thu.delegate = self
        pickerview_chi.delegate = self
        txt_tuithu.inputView = pickerview_thu
        txt_tuichi.inputView = pickerview_chi
        if listbagmoney.count>0 {
            txt_tuithu.text = listbagmoney[0].name
            txt_tuichi.text = listbagmoney[0].name
            bagmoneyselected_thu = listbagmoney[0]
            bagmoneyselected_chi = listbagmoney[0]
        }else{
            txt_tuichi.delegate = self
            txt_tuithu.delegate = self
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
    
    
    func customtoolbar(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Xong", style: .plain, target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        txt_tuichi.inputAccessoryView = keyboardToolbar
        txt_tuithu.inputAccessoryView = keyboardToolbar
    }
    
    func addNewBagMoneyCategory() -> Void{
//        var isExists = false
//        let alert = UIAlertController(title: "Thêm loại túi", message: nil, preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.placeholder = "Tên loại túi tiền"
//        }
//        alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { [weak alert] (_) in
//            for item in self.pickOption {
//                if item.name == alert?.textFields![0].text {
//                    isExists = true
//                    let alert_error = UIAlertController(title: "Lỗi", message: "Loại túi đã tồn tại", preferredStyle: .alert)
//                    alert_error.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
//                    self.present(alert_error,animated: true,completion: nil)
//                }
//            }
//            if !isExists {
//                let typebagmoney:BagMoney_Type = Database.create()
//                typebagmoney.name = alert?.textFields![0].text
//                self.bm_Type = typebagmoney
//                Database.save()
//                self.txt_loaitui.text = alert?.textFields![0].text
//                self.txt_loaitui.endEditing(true)
//                self.pickOption = Database.select(entityName: "BagMoney_Type") as! [BagMoney_Type]
//                
//            }
//        }))
//        alert.addAction(UIAlertAction(title: "Hủy", style: .default, handler: {[weak alert] (_) in
//            alert?.dismiss(animated: true, completion: nil)
//        }))
//        self.present(alert, animated: true, completion: nil)
    }
    
    //pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listbagmoney.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listbagmoney[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if listbagmoney.count <= 0 {
            self.txt_tuichi.text = ""
            self.txt_tuithu.text = ""
        }
        else{
            if pickerView == pickerview_thu {
                self.txt_tuithu.text = listbagmoney[row].name
            }else{
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


    func selectedcategoryfromThu(category: Category) {
        categorythu = category
        lbl_categorythu.text = category.name!
    }
    
    func selectedcategoryfromChi(category: Category) {
        categorychi = category
        lbl_categorychi.text = category.name!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseinclude" {
            let vc = segue.destination as! ChooseInclude_ViewController
            vc.customdelegate = self
        }
        if segue.identifier == "chooseexpense"{
            let vc = segue.destination as! ChooseExpense_ViewController
            vc.customdelegate = self
        }
    }

    @IBAction func ThemThuNhanh(_ sender: Any) {
        if lbl_categorythu.text == "" {
            let alert = UIAlertController(title: "Lỗi", message: "Danh mục chưa được chọn. Hãy chọn lại.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if txt_tuithu.text == "" {
            let alert = UIAlertController(title: "Lỗi", message: "Túi thu ko hợp lệ!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if Double(txt_tienthu.text!) == nil {
            let alert = UIAlertController(title: "Lỗi", message: "Số tiền có sẵn trong túi không đúng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            return
        }
        
        let alert = UIAlertController(title: "Đặt tên thu nhanh", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Tên thu nhanh"
        }
        alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { [weak alert] (_) in
            let temp:[Common] = Database.select(entityName: "Common", predicater: NSPredicate(format: "name = %@ AND category.category_type.name == 'Thu'",(alert?.textFields![0].text)!), sorter: nil) as! [Common]
            if temp.count <= 0 && alert?.textFields![0].text != ""{
                
                let common:Common = Database.create()
                common.category = self.categorythu
                common.bagmoney = self.bagmoneyselected_thu
                common.money = Double(self.txt_tienthu.text!)!
                common.name = alert?.textFields![0].text
                Database.save()
                
                let alert_notice = UIAlertController(title: "Thông báo", message: "Thêm thành công!", preferredStyle: .alert)
                alert_notice.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                self.present(alert_notice, animated: true, completion: nil)
                return
            }
            else{
                if alert?.textFields![0].text == ""{
                    let alert_notice = UIAlertController(title: "Lỗi", message: "Tên thu nhanh không được để trống!", preferredStyle: .alert)
                    alert_notice.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                    self.present(alert_notice, animated: true, completion: nil)
                    return
                }
                else{
                    let alert_notice = UIAlertController(title: "Lỗi", message: "Tên thu nhanh đã tồn tại, hãy đặt tên khác.", preferredStyle: .alert)
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
    @IBAction func ThemChiNhanh(_ sender: Any) {
        if lbl_categorychi.text == "" {
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
