//
//  SelectBagMoney_ViewController.swift
//  QuanLyThuChi
//
//  Created by Phạm Tú on 6/4/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class SelectBagMoney_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nav_item: UINavigationItem!
    @IBOutlet weak var btn_back: UIBarButtonItem!
    @IBOutlet weak var tblBagMoney: UITableView!
    
    var bagmoneys: [BagMoney] = []
    var identityTransfer: Int? = nil
    
    override func uiPassedData(data: Any?, identity: Int) {
        bagmoneys = Database.select(entityName: "BagMoney", predicater: nil, sorter: [NSSortDescriptor(key: "name", ascending: true)]) as! [BagMoney]
        tblBagMoney.reloadData()
        if(data == nil) {
            identityTransfer = 0
        }
        else {
            identityTransfer = data as? Int
        }
    }
    
    @IBAction func btn_back_TouchUpInside(_ sender: Any) {
        popData(data: nil, identity: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav_item.title = "Tài khoản"
        tblBagMoney.delegate = self
        tblBagMoney.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bagmoneys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBagMoney", for: indexPath) as! SelectBagMoney_TableViewCell
        if (bagmoneys[indexPath.row] as BagMoney?) != nil {
            cell.lblTen.text = bagmoneys[indexPath.row].name!
            cell.lblConLai.text = "ahihi"
            //            cell.lblConLai.text = "\(AppData.CurrencyFormatter(value: foods[indexPath.row].money))\(!foods[indexPath.row].is_use ? " - Ngừng kinh doanh" : "")"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        popData(data: bagmoneys[indexPath.row], identity: identityTransfer == 0 ? 2 : identityTransfer!)
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
