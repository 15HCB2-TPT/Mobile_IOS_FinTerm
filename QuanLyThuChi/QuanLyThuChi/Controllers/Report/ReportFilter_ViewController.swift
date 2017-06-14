//
//  ReportFilter_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/7/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class ReportFilter_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{




    @IBOutlet weak var btn_thongkengay: UIButton!
    @IBOutlet weak var lbl_denngay: UILabel!
    @IBOutlet weak var lbl_tungay: UILabel!
    @IBOutlet weak var btn_ThongKeThang: UIButton!
    @IBOutlet weak var lbl_ThangOfThang: UILabel!
    @IBOutlet weak var lbl_NamOfThang: UILabel!
    @IBOutlet weak var btn_ThongKeNam: UIButton!
    @IBOutlet weak var lbl_Nam: UILabel!
    @IBOutlet weak var lbl_ThoiGian: UILabel!
    @IBOutlet weak var lbl_Thongke: UILabel!
    
    //cum btn thoi gian
    @IBOutlet weak var btn_Nam: CheckBox!
    @IBOutlet weak var btn_Thang: CheckBox!
    @IBOutlet weak var btn_TuyChon: CheckBox!
    
    //cum view
    @IBOutlet weak var view_ThongKe: UIView!
    @IBOutlet weak var view_Nam: UIView!
    @IBOutlet weak var view_Thang: UIView!
    @IBOutlet weak var view_TuyChon: UIView!
    
    @IBOutlet weak var txt_DenNgay: UITextField!
    @IBOutlet weak var txt_TuNgay: UITextField!
    @IBOutlet weak var txt_NamOfThang: UITextField!
    @IBOutlet weak var txt_ThangOfThang: UITextField!
    @IBOutlet weak var txt_NamOfNam: UITextField!
    //custom
    let datePicker1 = UIDatePicker()
    let datePicker2 = UIDatePicker()
    let pickerview_NamOfNam = UIPickerView()
    let pickerview_ThangOfThang = UIPickerView()
    let pickerview_NamOfThang = UIPickerView()
    let month = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var year:[String] = []
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtext()
        Translater.AddForm(form: self)
        loadUI()
        createDatePicker()
        pickerview_NamOfNam.delegate = self
        pickerview_NamOfNam.dataSource = self
        pickerview_NamOfThang.delegate = self
        pickerview_NamOfThang.dataSource = self
        pickerview_ThangOfThang.delegate = self
        pickerview_ThangOfThang.dataSource = self
        
        txt_NamOfThang.inputAccessoryView = addDoneButton()
        txt_NamOfNam.inputAccessoryView = addDoneButton()
        txt_ThangOfThang.inputAccessoryView = addDoneButton()
        
        txt_NamOfNam.inputView = pickerview_NamOfNam
        txt_ThangOfThang.inputView = pickerview_ThangOfThang
        txt_NamOfThang.inputView = pickerview_NamOfThang
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
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
    
    func loadUI(){
        borderView(v: view_Nam)
        borderView(v: view_Thang)
        borderView(v: view_TuyChon)
        borderView(v: view_ThongKe)
        year = []
        for i in 2017 ... 2050 {
            year.append(String(i))
        }
        
        txt_NamOfNam.text = String(Calendar.current.component(.year, from: Date()))
        txt_ThangOfThang.text = String(Calendar.current.component(.month, from: Date()))
        txt_NamOfThang.text = String(Calendar.current.component(.year, from: Date()))
        txt_TuNgay.text = "Hôm nay"
        txt_DenNgay.text = "Hôm nay"
        
        moveUp(view: view_Nam)
        
    }
    
    func createDatePicker() {
        datePicker1.datePickerMode = .date
        datePicker2.datePickerMode = .date
        //toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([flexBarButton,doneButton],animated:false)
        
        txt_TuNgay.text = "Hôm nay"
        txt_DenNgay.text = "Hôm nay"
        txt_TuNgay.inputAccessoryView = toolbar
        txt_DenNgay.inputAccessoryView = toolbar
        txt_TuNgay.inputView = datePicker1
        txt_DenNgay.inputView = datePicker2
    }
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        txt_TuNgay.text = dateFormatter.string(from: datePicker1.date)
        txt_DenNgay.text = dateFormatter.string(from: datePicker2.date)
        self.view.endEditing(true)
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
    
    override func transReload() {
        loadtext()
    }
    
    func loadtext(){
        self.title = "Thống kê".trans
        btn_thongkengay.setTitle("Thống kê".trans, for: .normal)
        lbl_denngay.text = "Từ ngày".trans
        lbl_tungay.text = "Đến ngày".trans
        btn_ThongKeThang.setTitle("Thống kê".trans, for: .normal)
        lbl_ThangOfThang.text = "Tháng".trans
        lbl_NamOfThang.text = "Năm".trans
        btn_ThongKeNam.setTitle("Thống kê".trans, for: .normal)
        lbl_Nam.text = "Năm".trans
        lbl_ThoiGian.text = "Theo thời gian".trans
        lbl_Thongke.text = "Thống kê".trans
        
        //cum btn thoi gian
        btn_Nam.setTitle("Năm".trans, for: .normal)
        btn_Thang.setTitle("Tháng".trans, for: .normal)
        btn_TuyChon.setTitle("Tùy chọn".trans, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Click Chon loai thong ke
    
    //Click Chon loai thoi gian
    @IBAction func LoaiThoiGianClick(_ sender: Any) {
        if sender as! UIButton == btn_Nam {
            if btn_Nam.isChecked {
                btn_Nam.isChecked = false
            }else{
                btn_Nam.isChecked = true
                btn_Thang.isChecked = false
                btn_TuyChon.isChecked = false
                
                view_Nam.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 1
                    self.view_Thang.alpha = 0
                    self.view_TuyChon.alpha = 0
                })
            }
        }
        
        if sender as! UIButton == btn_Thang {
            if btn_Thang.isChecked {
                btn_Thang.isChecked = false
            }else{
                btn_Nam.isChecked = false
                btn_Thang.isChecked = true
                btn_TuyChon.isChecked = false
                
                view_Thang.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                    self.view_Thang.alpha = 1
                    self.view_TuyChon.alpha = 0
                })
            }
        }
        if sender as! UIButton == btn_TuyChon {
            if btn_TuyChon.isChecked {
                btn_TuyChon.isChecked = false
            }else{
                btn_Nam.isChecked = false
                btn_Thang.isChecked = false
                btn_TuyChon.isChecked = true
                
                view_TuyChon.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.view_Nam.alpha = 0
                    self.view_Thang.alpha = 0
                    self.view_TuyChon.alpha = 1
                })
            }
        }
        
        if !btn_Nam.isChecked && !btn_Thang.isChecked && !btn_TuyChon.isChecked {
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerview_NamOfThang {
            txt_NamOfThang.text = year[row]
        }
        else if pickerView == pickerview_ThangOfThang{
            txt_ThangOfThang.text = month[row]
        }
        else if pickerView == pickerview_NamOfNam{
            txt_NamOfNam.text = year[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerview_ThangOfThang {
            return month.count
        }else if pickerView == pickerview_NamOfThang{
            return year.count
        }else if pickerView == pickerview_NamOfNam{
            return year.count
        }else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerview_ThangOfThang {
            return month[row]
        }else if pickerView == pickerview_NamOfThang{
            return year[row]
        }else if pickerView == pickerview_NamOfNam{
            return year[row]
        }else{
            return "nil"
        }
    }
    
    
    //BTN Thong ke click ( ca 3 phan )
    
    @IBAction func btn_ThongKeTheoNam(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultReport") as! ResultReport_ViewController
        vc.nam = Int(txt_NamOfNam.text!)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_ThongKeTheoThang(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultReport") as! ResultReport_ViewController
        vc.thang = Int(txt_ThangOfThang.text!)!
        vc.nam = Int(txt_NamOfThang.text!)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_ThongKeTuyChon(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultReport") as! ResultReport_ViewController
        vc.fromdate = datePicker1.date
        vc.todate = datePicker2.date
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
