//
//  Control.swift
//  QuanLyQuanAn
//
//  Created by Phạm Tú on 4/17/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import UIKit

struct AppExtension {
    static func addCancelDoneButton(target: Any?, doneAct: Selector?, cancelAct: Selector?) -> UIToolbar {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done".localized(lang: AppLanguage.currentAppleLanguage()), style: .plain, target: target, action: doneAct)
        let cancelBarButton = UIBarButtonItem(title: "Cancel".localized(lang: AppLanguage.currentAppleLanguage()), style: .plain, target: target, action: cancelAct)
        keyboardToolbar.items = [cancelBarButton, flexBarButton, doneBarButton]
        return keyboardToolbar
    }
}

extension UIViewController {
    func addDoneButton() -> UIToolbar {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done"/*.localized(lang: AppLanguage.currentAppleLanguage())*/	, style: .plain, target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        return keyboardToolbar
    }
    
    func alert(title: String, msg: String, btnTitle: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func confirm(title: String, msg: String, btnOKTitle: String, btnCancelTitle: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: btnOKTitle, style: UIAlertActionStyle.default, handler: handler))
        alert.addAction(UIAlertAction(title: btnCancelTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func borderView(v:UIView){
        // border radius
        v.layer.cornerRadius = 10
        
        // border
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.layer.borderWidth = 1
        
        // drop shadow
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.8
        v.layer.shadowRadius = 3.0
        v.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    func dropshadowView(v:UIView){
        // border
        v.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        v.layer.borderWidth = 1
        
        // drop shadow
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.1
        v.layer.shadowRadius = 0.5
        v.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
}

extension AppDelegate {
    static func restart(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
    }
}

extension String {
    var doubleValue: Double {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.doubleValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
    
    //load change language
    func localized(lang:String)->String{
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: "Notification", bundle: bundle!, value: "", comment: "")
    }
}

extension UIColor {
    class func hex(string: String) -> UIColor {
        var hex = string.hasPrefix("#")
            ? String(string.characters.dropFirst())
            : string
        
        guard hex.characters.count == 6 || hex.characters.count == 8
            else { return UIColor.white.withAlphaComponent(0.0) }

        if hex.characters.count == 6 {
            hex = "FF" + hex
        }
        
        return UIColor(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)! >> 0) & 0xFF) / 255.0,
            alpha: CGFloat((Int(hex, radix: 16)! >> 24) & 0xFF) / 255.0)
    }
    
    class func hex(string: String,alpha: CGFloat) -> UIColor {
        var hex = string.hasPrefix("#")
            ? String(string.characters.dropFirst())
            : string
        
        guard hex.characters.count == 6 || hex.characters.count == 8
            else { return UIColor.white.withAlphaComponent(0.0) }
        
        if hex.characters.count == 6 {
            hex = "FF" + hex
        }
        
        return UIColor(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)! >> 0) & 0xFF) / 255.0,
            alpha: alpha)
    }
}
