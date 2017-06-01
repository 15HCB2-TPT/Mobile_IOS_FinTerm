//
//  BagMoney_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class BagMoney_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIPopoverPresentationControllerDelegate,UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var view_danhsachcuatoi: UIView!
    @IBOutlet weak var view_themtuitien: UIView!
    @IBOutlet weak var view_thongtin: UIView!
    @IBOutlet weak var txt_nametui: UITextField!
    @IBOutlet weak var txt_loaitui: UITextField!
    @IBOutlet weak var txt_sotien: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    var pickerView = UIPickerView()
    var pickOption = Database.select(entityName: "BagMoney_Type") as! [BagMoney_Type]
    var addBarButton:UIBarButtonItem? = nil
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        borderView(v: view_thongtin)
        borderView(v: view_danhsachcuatoi)
        borderView(v: view_themtuitien)
        
        txt_sotien.inputAccessoryView = addDoneButton()
        customtoolbar()
        //txt_loaitui.inputAccessoryView = addDoneButton()
        txt_nametui.inputAccessoryView = addDoneButton()
        
        pickerView.delegate = self
        txt_loaitui.inputView = pickerView
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    
    func customtoolbar(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewBagMoneyCategory))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [addBarButton!,flexBarButton, doneBarButton]
        txt_loaitui.inputAccessoryView = keyboardToolbar
        
    }
    
    func addNewBagMoneyCategory() -> Void{
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.txt_loaitui.text = textField?.text
            //print("Text field: \(textField?.text)")
        }))
        
        // 4. Present the alert.
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
            self.txt_loaitui.text = pickOption[row].name
        }
        
    }
    //
    
    @IBAction func AddClick(_ sender: Any) {
        let bm:BagMoney = Database.create()
        bm.money = Double(txt_sotien.text!)!
        bm.name = txt_nametui.text
        bm.bagmoney_type = pickOption[index]
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
