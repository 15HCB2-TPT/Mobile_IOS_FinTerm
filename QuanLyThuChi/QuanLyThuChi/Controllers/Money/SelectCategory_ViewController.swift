//
//  SelectCategory_ViewController.swift
//  QuanLyThuChi
//
//  Created by Phạm Tú on 5/31/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class SelectCategory_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nav_item: UINavigationItem!
    @IBOutlet weak var btn_back: UIBarButtonItem!
    @IBOutlet weak var tblCategory: UITableView!
    
    var categories: [Category] = []
    
    override func uiPassedData(data: Any?, identity: Int) {
        let dm = data as! String
        categories = Database.select(entityName: "Category", predicater: NSPredicate(format: "category_type.name = %@", dm), sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [Category]
        tblCategory.reloadData()
    }
    
    @IBAction func btn_back_TouchUpInside(_ sender: Any) {
        popData(data: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav_item.title = "Danh mục"
        tblCategory.delegate = self
        tblCategory.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategory", for: indexPath) as! SelectCategory_TableViewCell
        if (categories[indexPath.row] as Category?) != nil {
            cell.lblTen.text = categories[indexPath.row].name!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //pushData(storyboard: "Money", controller: "addRecord",  data: categories[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
