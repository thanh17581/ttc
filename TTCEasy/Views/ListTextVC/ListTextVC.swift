//
//  ListTextVC.swift
//  Tecomen
//
//  Created by TrungNV on 4/13/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit
import RxCocoa

struct ListItem {
    var id: String?
    var value: String?
}

class ListTextVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!

    class func getInstance() -> ListTextVC {
        return ListTextVC()
    }

    var strTitle = "Danh sách"
    var listItem: [ListItem] = []
    var listFilter = BehaviorRelay<[ListItem]>(value: [])

    var didSelect:((_ item: ListItem) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initUI() {
        super.initUI()
        lblTitle.text = strTitle
        tableView.register(ItemDropCell.self)
    }

    override func bindData() {
        super.bindData()
        tfSearch.rx.text.subscribe(onNext: {str in
            if str == nil || str!.trimed.isEmpty {
                self.listFilter.accept(self.listItem)
            }else{
                self.listFilter.accept(self.listItem.filter{$0.value.value().uppercased().removeDiacritics().contains(str.value().uppercased().removeDiacritics())})
            }
        }).disposed(by: disposeBag)

        listFilter.subscribe(onNext: { list in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismissOrPop()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilter.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemDropCell = tableView.dequeueReusableCell(for: indexPath)
        cell.lblValue.text = listFilter.value[indexPath.row].value.value()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let select = didSelect {
            select(listFilter.value[indexPath.row])
        }
        self.dismissOrPop()
    }
    
}
