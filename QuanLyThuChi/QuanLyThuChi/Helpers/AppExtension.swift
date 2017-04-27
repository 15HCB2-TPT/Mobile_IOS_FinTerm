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
        let doneBarButton = UIBarButtonItem(title: "Done".localized(lang: L102Language.currentAppleLanguage()), style: .plain, target: target, action: doneAct)
        let cancelBarButton = UIBarButtonItem(title: "Cancel".localized(lang: L102Language.currentAppleLanguage()), style: .plain, target: target, action: cancelAct)
        keyboardToolbar.items = [cancelBarButton, flexBarButton, doneBarButton]
        return keyboardToolbar
    }
}

extension UIViewController {
    func addDoneButton() -> UIToolbar {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done".localized(lang: L102Language.currentAppleLanguage()), style: .plain, target: view, action: #selector(UIView.endEditing(_:)))
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


