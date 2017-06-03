//
//  plus_TableViewCell.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/30/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class plus_TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_nametui: UILabel!
    @IBOutlet weak var lbl_money: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btn_info(_ sender: Any) {
    }
    @IBAction func btn_delete(_ sender: Any) {
    }

}
