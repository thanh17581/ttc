//
//  BaseCell.swift
//  TestTableView
//
//  Created by TrungNV on 2/10/20.
//  Copyright © 2020 trungnv. All rights reserved.
//

import Foundation
import UIKit

class BaseTableCell: UITableViewCell, ReusableView, NibLoadableView{
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.6) {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            else {
                self.transform = .identity
            }
        }
    }

    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
}

class BaseCollectionCell: UICollectionViewCell, ReusableView, NibLoadableView{
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.6) {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            else {
                self.transform = .identity
            }
        }
    }

    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
}
