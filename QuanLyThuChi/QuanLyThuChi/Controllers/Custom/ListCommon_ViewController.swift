//
//  ListCommon_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit
import CoreData

protocol ReloadData:class{
    func reloadData()
}
class ListCommon_ViewController: UIViewController,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,ReloadData {


    @IBOutlet weak var table_common: UITableView!
    @IBOutlet weak var view_notice: UIView!
    var listcommon: NSFetchedResultsController<Common> = Database.selectAndGroupBy(groupByColumn: "category.name")
    override func viewDidLoad() {
        super.viewDidLoad()
        table_common.delegate = self
        table_common.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    
    //tableview override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (listcommon.sections?[section].numberOfObjects)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commoncell", for: indexPath) as! CommonCell_TableViewCell
        let com = listcommon.object(at: indexPath)
        cell.lbl_name.text = com.name
        var loop = ""
        if com.loopday || com.loopmonth || com.loopyear  {
            if com.loopday {
                loop = String(com.looptime) + " " + "Ngày".trans(1)
            }
            if com.loopmonth {
                loop = String(com.looptime) + " " + "Tháng".trans
            }
            if com.loopyear {
                loop = String(com.looptime) + " " + "Năm".trans
            }
            cell.lbl_loop.text = "Tự lặp: " + loop
        }else{
            cell.lbl_loop.isHidden = true
        }
        if com.category?.category_type?.name == "Thu" {
            cell.lbl_money.textColor = UIColor.hex(string: "#2ecc71",alpha: 0.8)
        }
        else{
            cell.lbl_money.textColor = UIColor.hex(string: "#e74c3c",alpha: 0.8)
        }
        cell.lbl_money.text = com.money.cur
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Custom", bundle: nil).instantiateViewController(withIdentifier: "DetailCommon") as! DetailCommon_ViewController
        vc.common = listcommon.object(at: indexPath)
        vc.reloaddelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        //customdelegate?.selectedcategoryfromThu(category: thucategory[indexPath.row])
        //self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listcommon.sections!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
        return listcommon.sections![section].name
    }
    
    func reloadData() {
        listcommon = Database.selectAndGroupBy(groupByColumn: "category.name")
        print(listcommon.fetchedObjects?.count)
        table_common.reloadData()
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
