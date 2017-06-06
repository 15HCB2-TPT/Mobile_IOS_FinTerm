//
//  DetailCommon_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class DetailCommon_ViewController: UIViewController,UINavigationControllerDelegate,UIPickerViewDelegate,UITextFieldDelegate {

    var common = Common()
    var pickerview_tuitien = UIPickerView()
    var pickerview_thuchi = UIPickerView()
    var pickerview_danhmuc = UIPickerView()
    var reloaddelegate:ReloadData? = nil
    
    var listtuitien:[BagMoney] = Database.select()
    var listthuchi:[Type] = Database.select()
    var listdanhmucchi:[Category] = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Chi'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
    var listdanhmucthu:[Category] = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Thu'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
    
    @IBOutlet weak var txt_ten: UITextField!
    @IBOutlet weak var txt_tuitien: RightIcon_TextField!
    @IBOutlet weak var txt_thuchi: RightIcon_TextField!
    @IBOutlet weak var txt_danhmuc: RightIcon_TextField!
    @IBOutlet weak var txt_sotien: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processload()
        // Do any additional setup after loading the view.
    }
    
    func customtoolbar_pickerview(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Xong", style: .plain, target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        txt_tuitien.inputAccessoryView = keyboardToolbar
        txt_danhmuc.inputAccessoryView = keyboardToolbar
        txt_thuchi.inputAccessoryView = keyboardToolbar
        txt_tuitien.inputView = pickerview_tuitien
        txt_danhmuc.inputView = pickerview_danhmuc
        txt_thuchi.inputView = pickerview_thuchi
        
        pickerview_tuitien.delegate = self
        pickerview_thuchi.delegate = self
        pickerview_danhmuc.delegate = self
    }
    
    func processload(){
        customtoolbar_pickerview()
        //
        txt_ten.inputAccessoryView = addDoneButton()
        txt_sotien.inputAccessoryView = addDoneButton()
        
        txt_thuchi.delegate = self
        txt_danhmuc.delegate = self
        txt_tuitien.delegate = self
        txt_sotien.delegate = self
        txt_ten.delegate = self
        
        txt_ten.text = common.name
        txt_sotien.text = String(common.money)
        txt_tuitien.text = common.bagmoney?.name!
        txt_danhmuc.text = common.category?.name!
        txt_thuchi.text = common.category?.category_type?.name!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SaveClick(_ sender: Any) {
        if txt_ten.text == "" {
            let alert = UIAlertController(title: "Lỗi", message: "Tên không được để trống.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let temp = Database.select(entityName: "Common", predicater: NSPredicate(format: "name = %@ AND category.category_type.name = %@",argumentArray: [common.name!,txt_thuchi.text!]), sorter: nil) as! [Common]
        if temp.count >= 2 {
            let alert = UIAlertController(title: "Lỗi", message: "Tên thiết lập nhanh đã tồn tại.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if txt_tuitien.text == "" {
            let alert = UIAlertController(title: "Lỗi", message: "Hãy chọn túi tiền!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if Double(txt_sotien.text!) == nil {
            let alert = UIAlertController(title: "Lỗi", message: "Số tiền không đúng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            return
        }
        
        if common.category == nil {
            let alert = UIAlertController(title: "Lỗi", message: "Hãy chọn danh mục cho thiết lập nhanh.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            return
        }
        common.name = txt_ten.text
        common.money = Double(txt_sotien.text!)!
        Database.save()
        reloaddelegate?.reloadData()
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func CancelClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func DeleteClick(_ sender: Any) {
        Database.delete(object: common)
        Database.save()
        reloaddelegate?.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    //pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerview_danhmuc == pickerView {
            if txt_thuchi.text == "Thu" {
                return listdanhmucthu.count
            }else{
                return listdanhmucchi.count
            }
        }else if pickerview_tuitien == pickerView{
            return listtuitien.count
        }else{
            return listthuchi.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerview_danhmuc == pickerView {
            if txt_thuchi.text == "Thu" {
                return listdanhmucthu[row].name
            }else{
                return listdanhmucchi[row].name
            }
        }else if pickerview_tuitien == pickerView{
            return listtuitien[row].name
        }else{
            return listthuchi[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerview_danhmuc == pickerView {
            if txt_thuchi.text=="Thu" {
                txt_danhmuc.text = listdanhmucthu[row].name
                common.category = listdanhmucthu[row]
            }else{
                txt_danhmuc.text = listdanhmucchi[row].name
                common.category = listdanhmucchi[row]
            }
        }else if pickerview_tuitien == pickerView{
            if listtuitien.count <= 0 {
                txt_tuitien.text = ""
            }else{
                txt_tuitien.text = listtuitien[row].name
                common.bagmoney = listtuitien[row]
            }
        }else{
            if listthuchi.count <= 0 {
                txt_thuchi.text = ""
            }else{
                txt_thuchi.text = listthuchi[row].name
                if listthuchi[row].name != common.category?.category_type?.name {
                    txt_danhmuc.text = ""
                    common.category = nil
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txt_tuitien {
            if listtuitien.count <= 0 {
                let alert = UIAlertController(title: "Nhắc nhở", message: "Bạn chưa có túi tiền nào. Hãy tạo 1 cái trước.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            else{
                return true
            }
        }
        if textField == txt_danhmuc {
            if txt_thuchi.text=="Thu" {
                if listdanhmucthu.count <= 0 {
                    let alert = UIAlertController(title: "Nhắc nhở", message: "Bạn chưa có danh mục thu nào. Hãy tạo 1 cái trước.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }else{
                    return true
                }
            }
        }
        return true
    }
    
    //
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
