//
//  ListOfAllRequests.swift
//  TTCEasy
//
//  Created by Apple on 7/3/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit

class ListOfAllRequest {
    var kindOfRequest: String?
    var nameOfStaff: String?
    var kindOfDaySession: String?
    var timeDateStartAbsent: String?
    var timeDateEndAbsent: String?
    var status: String?
    
    required init?() {}
}

class ListOfAllRequestsVC: BaseVC {
    
    let listOfAllRequestCellId = "ListOfAllRequestCell"
    
    @IBOutlet weak var viewOfAll: UIView!
    @IBOutlet weak var viewOfWaiting: UIView!
    @IBOutlet weak var viewOfCancel: UIView!
    @IBOutlet weak var viewOfDone: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnListOfAllRequest: UIButton!
    @IBOutlet weak var btnListOfAllCancelRequest: UIButton!
    @IBOutlet weak var btnListOfAllDoneRequest: UIButton!
    @IBOutlet weak var btnListOfAllWaitingRequest: UIButton!
    
    
    var lists = [ListOfAllRequest]()
    var currentLists = [ListOfAllRequest]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.viewOfAll.backgroundColor = UIColor.orange
        self.viewOfDone.backgroundColor = UIColor.white
        self.viewOfCancel.backgroundColor = UIColor.white
        self.viewOfWaiting.backgroundColor = UIColor.white
        
        setupGradientBackground()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: listOfAllRequestCellId, bundle: nil), forCellReuseIdentifier: listOfAllRequestCellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        for _ in 1...5 {
            let list = ListOfAllRequest()
            list?.kindOfRequest = "Đơn yêu cầu nghỉ phép"
            list?.nameOfStaff = "TTC055 - Lê Hữu Thành"
            list?.kindOfDaySession = "Nửa ca sau"
            list?.timeDateStartAbsent = "08:20:00 15/06/2020"
            list?.timeDateEndAbsent = "12:00:00 15/06/2020"
            list?.status = "Huy"
            lists.append(list!)
        }
        for _ in 1...10 {
            let list = ListOfAllRequest()
            list?.kindOfRequest = "Đơn yêu cầu nghỉ phép"
            list?.nameOfStaff = "TTC055 - Lê Hữu Thành"
            list?.kindOfDaySession = "Nửa ca sau"
            list?.timeDateStartAbsent = "08:20:00 15/06/2020"
            list?.timeDateEndAbsent = "12:00:00 15/06/2020"
            list?.status = "Dong y"
            lists.append(list!)
        }
        for _ in 1...6 {
            let list = ListOfAllRequest()
            list?.kindOfRequest = "Đơn yêu cầu nghỉ phép"
            list?.nameOfStaff = "TTC055 - Lê Hữu Thành"
            list?.kindOfDaySession = "Nửa ca sau"
            list?.timeDateStartAbsent = "08:20:00 15/06/2020"
            list?.timeDateEndAbsent = "12:00:00 15/06/2020"
            list?.status = "Dang cho"
            lists.append(list!)
        }
        currentLists = lists
        tableView.reloadData()
        self.tableView.backgroundColor = #colorLiteral(red: 0.9631769061, green: 0.9294701219, blue: 0.9303787351, alpha: 1)
        var stringZ: String = "Tất cả (\(currentLists.count))"
        self.btnListOfAllRequest.setTitle(stringZ, for: .normal)
        stringZ = "Đã được duyệt (\(currentLists.filter({return $0.status == "Dong y"}).count))"
        self.btnListOfAllDoneRequest.setTitle(stringZ, for: .normal)
        stringZ = "Bị từ chối (\(currentLists.filter({return $0.status == "Huy"}).count))"
        self.btnListOfAllCancelRequest.setTitle(stringZ, for: .normal)
        stringZ = "Chờ duyệt (\(currentLists.filter({return $0.status == "Dang cho"}).count))"
        self.btnListOfAllWaitingRequest.setTitle(stringZ, for: .normal)
    }
    @IBAction func OnListOfAllRequestButtonTapped(_ sender: Any) {
        self.viewOfAll.backgroundColor = UIColor.orange
        self.viewOfDone.backgroundColor = UIColor.white
        self.viewOfCancel.backgroundColor = UIColor.white
        self.viewOfWaiting.backgroundColor = UIColor.white
        currentLists = lists
        tableView.reloadData()
    }
    @IBAction func OnListOfAllWaitingRequestButtonTapped(_ sender: Any) {
        self.viewOfWaiting.backgroundColor = UIColor.orange
        self.viewOfDone.backgroundColor = UIColor.white
        self.viewOfCancel.backgroundColor = UIColor.white
        self.viewOfAll.backgroundColor = UIColor.white
        currentLists = lists.filter({return $0.status == "Dang cho"})
        tableView.reloadData()
    }
    @IBAction func OnListOfAllDoneRequestButtonTapped(_ sender: Any) {
        self.viewOfDone.backgroundColor = UIColor.orange
        self.viewOfAll.backgroundColor = UIColor.white
        self.viewOfCancel.backgroundColor = UIColor.white
        self.viewOfWaiting.backgroundColor = UIColor.white
        currentLists = lists.filter({return $0.status == "Dong y"})
        tableView.reloadData()
    }
    @IBAction func OnListOfAllCancelRequestButtonTapped(_ sender: Any) {
        self.viewOfCancel.backgroundColor = UIColor.orange
        self.viewOfDone.backgroundColor = UIColor.white
        self.viewOfAll.backgroundColor = UIColor.white
        self.viewOfWaiting.backgroundColor = UIColor.white
        currentLists = lists.filter({return $0.status == "Huy"})
        tableView.reloadData()
    }
}

extension ListOfAllRequestsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listOfAllRequestCellId, for: indexPath) as! ListOfAllRequestCell
        cell.lblnameOfRequest.text = currentLists[indexPath.row].kindOfRequest
        cell.lblnameOfStaff.text = currentLists[indexPath.row].nameOfStaff
        cell.lblDaySessionOfDate.text = currentLists[indexPath.row].kindOfDaySession
        cell.timeDateStartAbsent.text = currentLists[indexPath.row].timeDateStartAbsent
        cell.timeDateEndAbsent.text = currentLists[indexPath.row].timeDateEndAbsent
        if currentLists[indexPath.row].status == "Huy" {
            cell.statusOfRequest.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else if currentLists[indexPath.row].status == "Dong y" {
            cell.statusOfRequest.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        } else if currentLists[indexPath.row].status == "Dang cho" {
            cell.statusOfRequest.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }
        return cell
    }
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = EditAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    @available(iOS 11.0, *)
    func EditAction (at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            completion(true)
        }
        action.image = UIImage(named: "ic_edit_button")
        action.backgroundColor = .gray
        return action
    }
    @available(iOS 11.0, *)
    func deleteAction (at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            AlertBuilder()
                .setSubText("Bạn có đồng ý đăng xuất?")
                .setAction1(withTitle: "Đồng ý") {
                    DispatchQueue.main.async(execute: {
                        self.currentLists.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        completion(true)
                        var stringZ: String = "Tất cả (\(self.currentLists.count))"
                        self.btnListOfAllRequest.setTitle(stringZ, for: .normal)
                        stringZ = "Đã được duyệt (\(self.currentLists.filter({return $0.status == "Dong y"}).count))"
                        self.btnListOfAllDoneRequest.setTitle(stringZ, for: .normal)
                        stringZ = "Bị từ chối (\(self.currentLists.filter({return $0.status == "Huy"}).count))"
                        self.btnListOfAllCancelRequest.setTitle(stringZ, for: .normal)
                        stringZ = "Chờ duyệt (\(self.currentLists.filter({return $0.status == "Dang cho"}).count))"
                        self.btnListOfAllWaitingRequest.setTitle(stringZ, for: .normal)
                    })
            }
            .setAction2(withTitle: "Huỷ", action: nil)
            .show()
        }
        action.image = UIImage(named: "ic_delete_button")
        action.backgroundColor = .red
        return action
    }
}
