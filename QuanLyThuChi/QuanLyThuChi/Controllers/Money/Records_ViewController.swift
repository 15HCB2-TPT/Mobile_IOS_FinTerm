//
//  Records_ViewController.swift
//  QuanLyThuChi
//
//  Created by Phạm Tú on 6/7/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Records_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nav_item: UINavigationItem!
    @IBOutlet weak var btn_back: UIBarButtonItem!
    @IBOutlet weak var tblMoney: UITableView!
    
    var moneys: [Money] = []
    
    override func uiPassedData(data: Any?, identity: Int) {
        moneys = Database.select(entityName: "Money", predicater: NSPredicate(format: "(transfer == nil) OR (transfer != nil AND money_category.category_type.name == 'Chi')"), sorter: [NSSortDescriptor(key: "date", ascending: false)]) as! [Money]
        tblMoney.reloadData()
    }
    
    @IBAction func btn_back_TouchUpInside(_ sender: Any) {
        popData(data: nil, identity: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav_item.title = "Đã ghi"
        tblMoney.delegate = self
        tblMoney.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moneys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecord", for: indexPath) as! Records_TableViewCell
        if (moneys[indexPath.row] as Money?) != nil {
            cell.lblDanhMuc.text = "\(String(describing: moneys[indexPath.row].money_category!.category_type!.name!)): \(String(describing: moneys[indexPath.row].money_category!.name!))"
            cell.lblSoTien.text = "\(moneys[indexPath.row].money)"
            cell.lblDienGiai.text = moneys[indexPath.row].reason
            cell.lblTaiKhoan.text = moneys[indexPath.row].money_bagmoney?.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        popData(data: bagmoneys[indexPath.row], identity: 2)
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
