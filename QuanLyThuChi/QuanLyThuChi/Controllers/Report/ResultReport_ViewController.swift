//
//  ResultReport_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 6/13/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit
import Charts

class ResultReport_ViewController: UIViewController,ChartViewDelegate,UINavigationControllerDelegate {
    
    //Data transfer
    var nam = 0
    var thang = 0
    var fromdate:Date? = nil
    var todate:Date? = nil
    var type:[Int] = []
    //
    
    @IBOutlet weak var btn_back: UIBarButtonItem!
    @IBOutlet weak var title_report: UINavigationItem!
    
    @IBOutlet weak var horizonChartView: HorizontalBarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    var listMoney:[Money] = Database.select()
    var thu = 0.0
    var chi = 0.0
    var listreportitem = [ReportItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtext()
        processData()
        let label = ["Thu","Chi"]
        let value = [thu,chi]

        setChart(dataPoints: label, values: value)
        setHorizontalBarChart()
        
        
        if thu == 0 && chi == 0 && listreportitem.count == 0 {
            let alerttemp = UIAlertController(title: "Thông báo".trans, message: "Không có dữ liệu để thống kê".trans, preferredStyle: .alert)
            self.present(alerttemp,animated:true,completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
                alerttemp.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            })
        }
        
        
    }
    
    func loadtext(){
        btn_back.title = "<Trở lại".trans
        title_report.title = "Thống kê".trans
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []
        let label = dataPoints[0]
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }

        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFormatter(PieFormatter.init(doublevalues: values))
        pieChartView.data = pieChartData
        pieChartView.legend.labels = [label]
    }
    @IBAction func BackClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setHorizontalBarChart() {
        
        horizonChartView.drawBarShadowEnabled = false
        horizonChartView.maxVisibleCount = 60
        horizonChartView.chartDescription?.text = "Thống kê".trans
        horizonChartView.legend.enabled = false


        horizonChartView.leftAxis.enabled = false
        horizonChartView.leftAxis.drawGridLinesEnabled = false
        horizonChartView.leftAxis.drawAxisLineEnabled = false
        
        horizonChartView.rightAxis.enabled = false
        horizonChartView.rightAxis.drawGridLinesEnabled = false
        horizonChartView.rightAxis.drawAxisLineEnabled = false
        
        horizonChartView.xAxis.drawGridLinesEnabled = false
        horizonChartView.xAxis.labelPosition = .bottom
        horizonChartView.xAxis.drawAxisLineEnabled = false
        horizonChartView.xAxis.granularity = 1.0
        horizonChartView.xAxis.axisMinimum = -0.5
        horizonChartView.xAxis.labelWidth = 0.5
        
        
        let formatter = ChartStringFormatter()
        formatter.nameValues = []
        for item in listMoney {
            var flag = false
            
            if thang == 0 {
                if nam != 0 && Calendar.current.component(.year, from: item.date as! Date) == nam {
                    for rpitem in listreportitem {
                        if item.money_category?.name == rpitem.category {
                            rpitem.money += item.money
                            flag = true
                            break
                        }
                    }
                    if !flag {
                        if item.money_category != nil {
                            let rp = ReportItem()
                            rp.category = (item.money_category?.name)!
                            rp.money = item.money
                            listreportitem.append(rp)
                            var flagname = false
                            for name in formatter.nameValues {
                                if name == rp.category {
                                    flagname = true
                                    break
                                }
                            }
                            if !flagname {
                                formatter.nameValues.append(rp.category)
                            }
                        }
                    }
                }
            }
            if thang != 0 && nam != 0 {
                if Calendar.current.component(.month, from: item.date as! Date) == thang && Calendar.current.component(.year, from: item.date as! Date) == nam {
                    for rpitem in listreportitem {
                        if item.money_category?.name == rpitem.category {
                            rpitem.money += item.money
                            flag = true
                            break
                        }
                    }
                    if !flag {
                        if item.money_category != nil {
                            let rp = ReportItem()
                            rp.category = (item.money_category?.name)!
                            rp.money = item.money
                            listreportitem.append(rp)
                            var flagname = false
                            for name in formatter.nameValues {
                                if name == rp.category {
                                    flagname = true
                                    break
                                }
                            }
                            if !flagname {
                                formatter.nameValues.append(rp.category)
                            }
                        }
                    }
                }
            }
            if fromdate != nil && todate != nil {
                if (item.date as! Date) > fromdate! && (item.date as! Date) < todate! {
                    for rpitem in listreportitem {
                        if item.money_category?.name == rpitem.category {
                            rpitem.money += item.money
                            flag = true
                            break
                        }
                    }
                    if !flag {
                        if item.money_category != nil {
                            let rp = ReportItem()
                            rp.category = (item.money_category?.name)!
                            rp.money = item.money
                            listreportitem.append(rp)
                            var flagname = false
                            for name in formatter.nameValues {
                                if name == rp.category {
                                    flagname = true
                                    break
                                }
                            }
                            if !flagname {
                                formatter.nameValues.append(rp.category)
                            }
                        }
                    }
                }
            }
        }
        horizonChartView.xAxis.valueFormatter = formatter
        
  
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<listreportitem.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [listreportitem[i].money], label: "")
            dataEntries.append(dataEntry)
        }

        
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "")
        barChartDataSet.drawValuesEnabled = true
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.barWidth = 0.4
        horizonChartView.data = barChartData
        
    }
    
    func processData(){
        for item in listMoney {
            if item.money_type?.name! == "Thu" {
                if thang == 0 {
                    if nam != 0 && Calendar.current.component(.year, from: item.date as! Date) == nam {
                        thu += item.money
                    }
                }
                if thang != 0 && nam != 0 {
                    if Calendar.current.component(.month, from: item.date as! Date) == thang && Calendar.current.component(.year, from: item.date as! Date) == nam {
                        thu += item.money
                    }
                }
                if fromdate != nil && todate != nil {
                    if (item.date as! Date) > fromdate! && (item.date as! Date) < todate! {
                        thu += item.money
                    }
                }
            }else{
                if thang == 0 {
                    if nam != 0 && Calendar.current.component(.year, from: item.date as! Date) == nam {
                        chi += item.money
                    }
                }
                if thang != 0 && nam != 0 {
                    if Calendar.current.component(.month, from: item.date as! Date) == thang && Calendar.current.component(.year, from: item.date as! Date) == nam {
                        chi += item.money
                    }
                }
                if fromdate != nil && todate != nil {
                    if (item.date as! Date) > fromdate! && (item.date as! Date) < todate! {
                        chi += item.money
                    }
                }
            }
        }
        
        
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
