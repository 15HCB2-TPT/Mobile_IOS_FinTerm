//
//  ExpenseCategory_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/4/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class ExpenseCategory_ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var lbl_chi: UILabel!
    @IBOutlet weak var table_ChiCategory: UITableView!
    var chicategory:[Category] = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Chi'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_chi.text = "Chi".trans
        table_ChiCategory.dataSource = self
        table_ChiCategory.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload(){
        chicategory = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Chi'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
        table_ChiCategory.reloadData()
    }
    
    //tableview override
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chicategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorycell_chi", for: indexPath) as! Category_TableViewCell
        cell.lbl_name.text = chicategory[indexPath.row].name
        return cell
    }
    //end table view

    @IBAction func DeleteClick(_ sender: Any) {
        if let cell = (sender as AnyObject).superview??.superview as? Category_TableViewCell {
            let indexPath:IndexPath = table_ChiCategory.indexPath(for: cell)!
            let alert = UIAlertController(title: "Cảnh báo", message: "Bạn có muốn xóa danh mục này? Tiếp tục", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { (_) in
                for item in Database.select(entityName: "Money") as! [Money]{
                    if item.money_category == self.chicategory[indexPath.row]{
                        item.money_category = nil
                    }
                }
                Database.delete(object: self.chicategory[indexPath.row])
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
