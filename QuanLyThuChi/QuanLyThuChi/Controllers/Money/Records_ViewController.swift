//
//  Records_ViewController.swift
//  QuanLyThuChi
//
//  Created by Phạm Tú on 6/7/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit
import CoreData

class Records_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nav_item: UINavigationItem!
    @IBOutlet weak var btn_back: UIBarButtonItem!
    @IBOutlet weak var tblMoney: UITableView!

    var moneys: NSFetchedResultsController<Money>!
    
    @IBAction func btn_back_TouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav_item.title = "Đã ghi"
        tblMoney.delegate = self
        tblMoney.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moneys = Database.selectAndGroupBy(groupByColumn: "date.dateWithoutTime", predicater: NSPredicate(format: "(transfer == nil) OR (transfer != nil AND money_type.name == 'Chi')"), sorter: [NSSortDescriptor(key: "date", ascending: false)])
        tblMoney.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moneys.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moneys.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        return df.string(from: (moneys.sections?[section].objects?[0] as! Money).date! as Date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecord", for: indexPath) as! Records_TableViewCell
        if let m = moneys.sections?[indexPath.section].objects?[indexPath.row] as! Money? {
            if(m.transfer == nil) {
                cell.lblDanhMuc.text = "\(String(describing: m.money_type!.name!)): \(String(describing: m.money_category!.name!))"
            }
            else {
                cell.lblDanhMuc.text = "Chuyển tới: \(String(describing: m.transfer!.money_bagmoney!.name!))"
            }
            cell.lblSoTien.text = "\(m.money.cur)"
            cell.lblDienGiai.text = m.reason
            cell.lblTaiKhoan.text = m.money_bagmoney?.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let m = moneys.sections?[indexPath.section].objects?[indexPath.row] as! Money? {
            if(m.transfer == nil) {
                pushData(storyboard: "Money", controller: "editRecord", data: moneys.sections?[indexPath.section].objects?[indexPath.row], identity: 3)
            }
            else {
                pushData(storyboard: "Money", controller: "editTransfer", data: moneys.sections?[indexPath.section].objects?[indexPath.row], identity: 3)
            }
        }
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
