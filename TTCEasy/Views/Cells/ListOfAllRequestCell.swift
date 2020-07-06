//
//  ListOfAllRequestCell.swift
//  TTCEasy
//
//  Created by Apple on 7/6/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit

class ListOfAllRequestCell: UITableViewCell {

    @IBOutlet weak var lblnameOfStaff: UILabel!
    @IBOutlet weak var lblnameOfRequest: UILabel!
    @IBOutlet weak var statusOfRequest: UIView!
    @IBOutlet weak var lblDaySessionOfDate: UILabel!
    @IBOutlet weak var timeDateStartAbsent: UILabel!
    @IBOutlet weak var timeDateEndAbsent: UILabel!
    @IBOutlet weak var spaceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.spaceView.backgroundColor = #colorLiteral(red: 0.9631769061, green: 0.9294701219, blue: 0.9303787351, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
