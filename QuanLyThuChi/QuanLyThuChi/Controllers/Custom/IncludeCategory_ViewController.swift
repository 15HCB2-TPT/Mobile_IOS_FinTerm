//
//  IncludeCategory_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/4/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class IncludeCategory_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var lbl_thu: UILabel!

    @IBOutlet weak var table_ThuCategory: UITableView!
    var thucategory:[Category] = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Thu'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_thu.text = "Thu".trans
        table_ThuCategory.dataSource = self
        table_ThuCategory.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload(){
        thucategory = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Thu'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
        table_ThuCategory.reloadData()
    }
    
    //tableview override
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return thucategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorycell_thu", for: indexPath) as! Category_TableViewCell
        cell.lbl_name.text = thucategory[indexPath.row].name
        return cell
    }
    //end table view
    
    @IBAction func DeleteClick(_ sender: Any) {
        if let cell = (sender as AnyObject).superview??.superview as? Category_TableViewCell {
            let indexPath:IndexPath = table_ThuCategory.indexPath(for: cell)!
            let alert = UIAlertController(title: "Cảnh báo", message: "Bạn có muốn xóa danh mục này? Tiếp tục", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { (_) in
                for item in Database.select(entityName: "Money") as! [Money]{
                    if item.money_category == self.thucategory[indexPath.row]{
                        item.money_category = nil
                    }
                }
                Database.delete(object: self.thucategory[indexPath.row])
                Database.save()
                self.reload()
            }))
            alert.addAction(UIAlertAction(title: "Hủy", style: .default, handler: {[weak alert] (_) in
                alert?.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
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
