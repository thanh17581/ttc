//
//  CalendarCollectionCell.swift
//  TTCEasy
//
//  Created by TrungNV on 6/5/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit

class CalendarCollectionCell: BaseCollectionCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSub: UILabel!

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewRight: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        lblDate.cornerRadius = lblDate.bounds.height / 2
        lblDate.clipsToBounds = true
    }

    func configCell(_ data: CustomDate, isExpanded: Bool) {
        if let date = data.Date {
            let dateStr = date >= 10 ? "\(date)" : "0\(date)"
            lblDate.text = dateStr
        }else{
            lblDate.text = nil
        }
        lblSub.text = data.subText.trimed
        lblDate.textColor = data.isDayOff ? Colors.growTextColor : Colors.backTextColor

        switch data.state {
        case .Late:
            lblDate.backgroundColor = Colors.lateColor
        case .DayOff:
            lblDate.backgroundColor = Colors.dayOffColor
        case .Current:
            lblDate.backgroundColor = Colors.currentColor
        default:
            lblDate.backgroundColor = .clear
        }

        if isExpanded {
            hideBorder(false)
            lblSub.isHidden = false
        }else{
            hideBorder(true)
            lblSub.isHidden = true
        }
    }

    func hideBorder(_ isHidden: Bool) {
        viewTop.isHidden = isHidden
        viewLeft.isHidden = isHidden
        viewBottom.isHidden = isHidden
        viewRight.isHidden = isHidden
    }

}
