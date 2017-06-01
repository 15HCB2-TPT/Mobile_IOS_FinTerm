//
//  Records_TableViewCell.swift
//  QuanLyThuChi
//
//  Created by Phạm Tú on 5/31/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Records_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDanhMuc: UILabel!
    @IBOutlet weak var lblSoTien: UILabel!
    @IBOutlet weak var lblDienGiai: UILabel!
    @IBOutlet weak var lblTaiKhoan: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
