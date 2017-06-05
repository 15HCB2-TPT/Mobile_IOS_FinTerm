//
//  CategoryExpense_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/4/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class ChooseExpense_ViewController: UIViewController,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var table_categoryChi: UITableView!
    var chicategory:[Category] = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name == 'Chi'"), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
    var customdelegate:SelectedCategory? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_categoryChi.delegate = self
        table_categoryChi.dataSource = self
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
        return chicategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! Category_TableViewCell
        cell.lbl_name.text = chicategory[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customdelegate?.selectedcategoryfromChi(category: chicategory[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }

}
