//
//  SettingController.swift
//  QuanLyThuChi
//
//  Created by Hiroshi.Kazuo on 6/13/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class SettingController: UIViewController {

    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var rbVietnamese: CheckBox!
    @IBOutlet weak var rbEnglish: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtext()
        // Do any additional setup after loading the view.
        Translater.AddForm(form: self)
        changeLan(lanValue: UserDefaults.standard.integer(forKey: AppConfigs.LANGUAGE_KEY))
    }
    override func transReload() {
        loadtext()
    }
    func loadtext(){
        self.title = "Cài đặt".trans
        labelLanguage.text = "Ngôn ngữ".trans
        rbVietnamese.setTitle("Tiếng Việt".trans, for: .normal)
        rbEnglish.setTitle("Tiếng Anh".trans, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rbVietnamese_Click(_ sender: Any) {
        changeLan(lanValue: -1)
    }
    
    @IBAction func rbEnglish_Click(_ sender: Any) {
        changeLan(lanValue: 0)
    }
    
    func changeLan(lanValue: Int){
        Translater.ChangeTransIndex(lanValue)
        if lanValue == -1 {
            UserDefaults.standard.set("vi_VN", forKey: AppConfigs.CURRENCY_KEY)
            rbVietnamese.isChecked = true
            rbEnglish.isChecked = false
        } else if lanValue == 0 {
            UserDefaults.standard.set("en_US", forKey: AppConfigs.CURRENCY_KEY)
            rbEnglish.isChecked = true
            rbVietnamese.isChecked = false
        }
        UserDefaults.standard.set(lanValue, forKey: AppConfigs.LANGUAGE_KEY)
    }

}
