//
//  DropTextField.swift
//  Tecomen
//
//  Created by TrungNV on 4/13/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit
import SnapKit

protocol DropTextFieldDelegate {
    func didTouch(_ dropTextField: DropTextField);
}

class DropTextField: UITextField {

    var dropDelegate: DropTextFieldDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupUI() {
        let view = UIView()
        view.backgroundColor = .clear
        let imgView = UIImageView()
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
        }
        imgView.image = UIImage(named: "ic_down_narrow")
        imgView.contentMode = .center

        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.bringSubviewToFront(view)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let dele = self.dropDelegate {
            dele.didTouch(self)
        }
    }
}
