//
//  Category_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/4/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Category_ViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var btn_back: UIBarButtonItem!
    
    
    @IBOutlet weak var container_Chi: UIView!
    @IBOutlet weak var container_Thu: UIView!
    @IBOutlet weak var segmented: UISegmentedControl!
    var viewthu:IncludeCategory_ViewController? = nil
    var viewchi:ExpenseCategory_ViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtext()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadtext(){
        btn_back.title = "<Trở lại".trans
        segmented.setTitle("Thu".trans, forSegmentAt: 0)
        segmented.setTitle("Chi".trans, forSegmentAt: 1)
    }
    
    @IBAction func BackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddClick(_ sender: Any) {
        let danhmuc:[Category] = Database.select()
        switch segmented.selectedSegmentIndex {
        case 0:
            let alert = UIAlertController(title: "Thêm danh mục", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Tên danh mục"
            }
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { [weak alert] (_) in
                for item in danhmuc{
                    if item.category_type?.name == "Thu" && item.name == alert?.textFields![0].text{
                        let alert_error = UIAlertController(title: "Lỗi", message: "Danh mục đã tồn tại", preferredStyle: .alert)
                        alert_error.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                        self.present(alert_error,animated: true,completion: nil)
                        return
                    }
                }
                let newcate:Category = Database.create()
                newcate.category_type = Database.select(entityName: "Type", predicater: NSPredicate(format: "name == 'Thu'"))[0] as! Type
                newcate.name = alert?.textFields![0].text
                Database.save()
                // reload Thu
                self.viewthu?.reload()
            }))
            alert.addAction(UIAlertAction(title: "Hủy", style: .default, handler: {[weak alert] (_) in
                alert?.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        case 1:
            let alert = UIAlertController(title: "Thêm danh mục", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Tên danh mục"
            }
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { [weak alert] (_) in
                for item in danhmuc{
                    if item.category_type?.name == "Chi" && item.name == alert?.textFields![0].text{
                        let alert_error = UIAlertController(title: "Lỗi", message: "Danh mục đã tồn tại", preferredStyle: .alert)
                        alert_error.addAction(UIAlertAction(title: "Xong", style: .default, handler: nil))
                        self.present(alert_error,animated: true,completion: nil)
                        return
                    }
                }
                
                let newcate:Category = Database.create()
                newcate.category_type = Database.select(entityName: "Type", predicater: NSPredicate(format: "name == 'Chi'"))[0] as! Type
                newcate.name = alert?.textFields![0].text
                Database.save()
                // reload Chi
                self.viewchi?.reload()
            }))
            alert.addAction(UIAlertAction(title: "Hủy", style: .default, handler: {[weak alert] (_) in
                alert?.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
    
    @IBAction func segmentedChanged(_ sender: Any) {
        switch segmented.selectedSegmentIndex {
        case 0:
            container_Chi.isHidden = true
            container_Thu.isHidden = false
        case 1:
            container_Chi.isHidden = false
            container_Thu.isHidden = true
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedthu" {
            viewthu = segue.destination as? IncludeCategory_ViewController
        }
        if segue.identifier == "embedchi" {
            viewchi = segue.destination as? ExpenseCategory_ViewController
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

}
