//
//  CategoryInclude_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/4/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class ChooseInclude_ViewController: UIViewController,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var table_categoryThu: UITableView!
    var thucategory:[Category] = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Thu'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
    var customdelegate:SelectedCategory? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        table_categoryThu.delegate = self
        table_categoryThu.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    //tableview override
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return thucategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! Category_TableViewCell
        cell.lbl_name.text = thucategory[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customdelegate?.selectedcategoryfromThu(category: thucategory[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    //end table view
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
