//
//  ResultReport_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 6/13/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit
import Charts

class ResultReport_ViewController: UIViewController,ChartViewDelegate {
    
    @IBOutlet weak var horizonChartView: HorizontalBarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    var listMoney:[Money] = Database.select()
    var thu = 0.0
    var chi = 0.0
    var listreportitem = [ReportItem]()
    override func viewDidLoad() {
        super.viewDidLoad()

        processData()
        let label = ["Thu","Chi"]
        let value = [thu,chi]

        setChart(dataPoints: label, values: value)
        setHorizontalBarChart()
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
        pieChartView.data = pieChartData
        pieChartView.legend.labels = [label]
    }
    
    func setHorizontalBarChart() {
        
        horizonChartView.drawBarShadowEnabled = false
        horizonChartView.maxVisibleCount = 60
        horizonChartView.chartDescription?.text = "Horizontal Bar Chart"
        
        
        
        let formatter = ChartStringFormatter()
        formatter.nameValues = []
        
        var flag = false
        for item in listMoney {
            for rpitem in listreportitem {
                if item.money_category?.name == rpitem.category {
                    rpitem.money += item.money
                    flag = true
                    break
                }
            }
            if !flag {
                let rp = ReportItem()
                rp.category = (item.money_category?.name)!
                rp.money = item.money
                listreportitem.append(rp)
                formatter.nameValues.append(rp.category)
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
        barChartData.barWidth = 0.2
        horizonChartView.drawValueAboveBarEnabled = true
        horizonChartView.data = barChartData
        
    }
    
    func processData(){
        
        
        for item in listMoney {
            if item.money_type?.name! == "Thu" {
                thu += item.money
            }else{
                chi += item.money
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
