//
//  BagMoney_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit
protocol BagMoneyProtocol : class {
    func reload()
}

class BagMoney_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIPopoverPresentationControllerDelegate,UINavigationControllerDelegate,BagMoneyProtocol{
    

    
    
    @IBOutlet weak var lbl_minusbagmoney: UILabel!
    @IBOutlet weak var lbl_totalnumberbagmoney: UILabel!
    @IBOutlet weak var lbl_totalmoney: UILabel!
    @IBOutlet weak var lbl_info: UILabel!
    @IBOutlet weak var btn_addbagmoney: UIButton!
    @IBOutlet weak var lbl_money: UILabel!
    @IBOutlet weak var lbl_typebagmoney: UILabel!
    @IBOutlet weak var lbl_namebagmoney: UILabel!
    @IBOutlet weak var lbl_textAddBagMoney: UILabel!
    @IBOutlet weak var lbl_textHeaderBagMoney: UILabel!
    @IBOutlet weak var btn_mylistbagmoney: UIButton!
    @IBOutlet weak var lbl_tongtien: UILabel!
    @IBOutlet weak var lbl_tongtui: UILabel!
    @IBOutlet weak var lbl_sotuiam: UILabel!
    @IBOutlet weak var view_danhsachcuatoi: UIView!
    @IBOutlet weak var view_themtuitien: UIView!
    @IBOutlet weak var view_thongtin: UIView!
    @IBOutlet weak var txt_nametui: UITextField!
    @IBOutlet weak var txt_loaitui: UITextField!
    @IBOutlet weak var txt_sotien: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    var bm_Type:BagMoney_Type? = nil
    var pickerView = UIPickerView()
    var pickOption = Database.select(entityName: "BagMoney_Type") as! [BagMoney_Type]
    var addBarButton:UIBarButtonItem? = nil
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Translater.AddForm(form: self)
        
        processThongTinCaNhan()
        loadtext()
        borderView(v: view_thongtin)
        borderView(v: view_danhsachcuatoi)
        borderView(v: view_themtuitien)
        
        txt_sotien.inputAccessoryView = addDoneButton()
        customtoolbar()
        txt_nametui.inputAccessoryView = addDoneButton()
        
        pickerView.delegate = self
        txt_loaitui.inputView = pickerView
        if pickOption.count > 0 {
            txt_loaitui.text = pickOption[0].name
            bm_Type = pickOption[0]
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func transReload() {
        loadtext()
    }
    
    func loadtext(){
        self.title = "Tài khoản".trans
        lbl_minusbagmoney.text = "Số tài khoản âm".trans
        lbl_totalnumberbagmoney.text = "Tổng số tài khoản".trans
        lbl_totalmoney.text = "Tổng số tiền".trans
        lbl_info.text = "Thông tin cá nhân".trans
        btn_addbagmoney.setTitle("Thêm tài khoản".trans, for: UIControlState.normal)
        lbl_money.text = "Số tiền".trans
        lbl_typebagmoney.text = "Loại tk".trans
        lbl_namebagmoney.text = "Tên tk".trans
        lbl_textAddBagMoney.text = "Thêm tài khoản mới".trans
        lbl_textHeaderBagMoney.text = "Tài khoản".trans
        btn_mylistbagmoney.setTitle("Danh sách tài khoản của tôi".trans, for: UIControlState.normal)
        txt_nametui.placeholder = "Tên tài khoản".trans
        txt_loaitui.placeholder = "Loại tài khoản".trans
        txt_sotien.placeholder = "Số tiền".trans
    }
    
    func reload() {
        processThongTinCaNhan()
        clearAllTextField()
    }

    func processThongTinCaNhan(){
        var totalmoney:Double = 0
        let temp:[BagMoney] = Database.select()
        var count:Int = 0
        for item in temp {
            totalmoney += item.money
            if item.money < 0 {
                count += 1
            }
        }
        

        lbl_tongtien.text = totalmoney.cur
        lbl_sotuiam.text = String(count)
        if totalmoney > 0 {
            lbl_tongtien.textColor = UIColor.hex(string: "#2ecc71")
        }else if totalmoney == 0{
            lbl_tongtien.textColor = UIColor.black
        }
        else{
            lbl_tongtien.textColor = UIColor.hex(string: "#e74c3c")
        }
        lbl_tongtui.text = String(temp.count)
        if count == 0 {
            lbl_sotuiam.textColor = UIColor.black
        }else{
            lbl_sotuiam.textColor = UIColor.hex(string: "#e74c3c")
        }
        
    }
    func clearAllTextField(){
        txt_sotien.text = ""
        txt_loaitui.text = ""
        txt_nametui.text = ""
    }
    
    func customtoolbar(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        addBarButton = UIBarButtonItem(title: "Thêm".trans, style: .plain, target: self, action: #selector(addNewBagMoneyCategory))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Xong".trans, style: .plain, target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [addBarButton!,flexBarButton, doneBarButton]
        txt_loaitui.inputAccessoryView = keyboardToolbar
    }
    
    func addNewBagMoneyCategory() -> Void{
        var isExists = false
        let alert = UIAlertController(title: "Thêm loại tài khoản".trans, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Tên loại tài khoản".trans
        }
        alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: { [weak alert] (_) in
            for item in self.pickOption {
                if item.name == alert?.textFields![0].text {
                    isExists = true
                    let alert_error = UIAlertController(title: "Lỗi".trans, message: "Loại túi đã tồn tại".trans, preferredStyle: .alert)
                    alert_error.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
                    self.present(alert_error,animated: true,completion: nil)
                }
            }
            if !isExists {
                let typebagmoney:BagMoney_Type = Database.create()
                typebagmoney.name = alert?.textFields![0].text
                self.bm_Type = typebagmoney
                Database.save()
                self.txt_loaitui.text = alert?.textFields![0].text
                self.txt_loaitui.endEditing(true)
                self.pickOption = Database.select(entityName: "BagMoney_Type") as! [BagMoney_Type]

            }
        }))
        alert.addAction(UIAlertAction(title: "Hủy".trans, style: .default, handler: {[weak alert] (_) in
            alert?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //check
        return pickOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //check
        return pickOption[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
        if pickOption.count <= 0 {
            self.txt_loaitui.text = ""
        }
        else{
            bm_Type = pickOption[row]
            self.txt_loaitui.text = pickOption[row].name
        }
    }
    //
    
    @IBAction func AddClick(_ sender: Any) {
        for item in pickOption {
            if item.name == txt_loaitui.text {
                bm_Type = item
                break
            }
        }
        if txt_nametui.text! == "" {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Hãy nhập tên túi tiền".trans, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            return
        }
        
        if Double(txt_sotien.text!) == nil {
            let alert = UIAlertController(title: "Lỗi".trans, message: "Số tiền có sẵn trong túi không đúng".trans, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            return
        }
        if bm_Type == nil {
            let alert_error = UIAlertController(title: "Lỗi".trans, message: "Loại túi không tồn tại".trans, preferredStyle: .alert)
            alert_error.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
            self.present(alert_error,animated: true,completion: nil)
            return
        }
        
        let bm:BagMoney = Database.create()
        bm.money = Double(txt_sotien.text!)!
        bm.name = txt_nametui.text
        bm.bagmoney_type = bm_Type
        bm.date = NSDate()
        Database.save()
        let alert = UIAlertController(title: "Thành công".trans, message: "Đã thêm túi tiền mới thành công!".trans, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Xong".trans, style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
        self.processThongTinCaNhan()
        self.clearAllTextField()
        }
    
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listbagmoney" {
            let vc = segue.destination as! ListBagMoney_ViewController
            vc.bagmoneydelegate = self
        }
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


