//
//  ListBagMoney_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class ListBagMoney_ViewController: UIViewController,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate {

    
    var sections:[BagMoney_Type] = Database.select()
    var listBagMoney:[BagMoney] = Database.select()
    var rl = [BagMoney]()
    var temp=[[BagMoney]]()
    var bagmoneydelegate:BagMoneyProtocol? = nil
    
    @IBOutlet weak var table_tuitien: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        processSection()
        table_tuitien.delegate = self
        table_tuitien.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func processSection(){
        listBagMoney.sort(by: sortByMoneyBagMoney(before:after:))
        for i in 0 ... sections.count - 1{
            temp.append([BagMoney]())
            for item in listBagMoney {
                if item.bagmoney_type == sections[i] {
                    temp[i].append(item)
                }
            }
        }
        var temptemp = [[BagMoney]]()
        var tempsections = [BagMoney_Type]()
        for i in 0 ... temp.count - 1 {
            if temp[i].count > 0 {
                temptemp.append(temp[i])
                tempsections.append(sections[i])
            }
        }
        temp = temptemp
        sections = tempsections
    }
    
    func sortByMoneyBagMoney(before: BagMoney, after: BagMoney)-> Bool{
        return before.money > after.money
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backClick(_ sender: Any) {
        bagmoneydelegate?.reload()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //tableview override
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return temp[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plus_TableViewCell", for: indexPath) as! plus_TableViewCell
        cell.lbl_nametui.text = temp[indexPath.section][indexPath.row].name
        cell.lbl_money.text = temp[indexPath.section][indexPath.row].money.cur
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->String? {
        if temp[section].count<=0 {
            return nil
        }
        return temp[section][0].bagmoney_type?.name
    }
    //end table view
    
    @IBAction func deleteClick(_ sender: Any) {
        if let cell = (sender as AnyObject).superview??.superview as? plus_TableViewCell {
            let indexPath:IndexPath = table_tuitien.indexPath(for: cell)!
            let alert = UIAlertController(title: "Cảnh báo", message: "Thu chi sẽ bị xóa theo túi tiền, bạn có muốn tiếp tục", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xong", style: .default, handler: { (_) in
                for item in Database.select(entityName: "Money") as! [Money]{
                    if item.money_bagmoney == self.temp[indexPath.section][indexPath.row]{
                        Database.delete(object: item)
                    }
                }
                Database.delete(object: self.temp[indexPath.section][indexPath.row])
                Database.save()
                self.temp.removeAll()
                self.temp = [[BagMoney]]()
                self.processSection()
                self.table_tuitien.reloadData()
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
