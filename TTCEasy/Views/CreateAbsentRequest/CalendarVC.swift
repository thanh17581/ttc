//
//  CalendarVC.swift
//  TTCEasy
//
//  Created by Apple on 6/26/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//Mark: Protocol setting

protocol PassStartDate {
    func PassStartDate(string: String)
    func setTitle1(string: String)
}
protocol PassEndDate {
    func PassEndDate(string: String)
    func setTitle2(string: String)
}
class CalendarVC: BaseVC {

    //Mark: Properties Setting
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnTitle: UIButton!

    let vm = HomeVM()
    var delegate1 : PassStartDate?
    var delegate2 : PassEndDate?
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        contentSizeInPopup = CGSize(width: 400, height: 350)
        popupController?.cornerRadius = CGFloat(20)
    }
    override func initData() {
    collectionView.register(CalendarCollectionCell.self)
    }
    override func bindData() {
        super.bindData()
        Observable.combineLatest(vm.currentYear, vm.currentMonth, resultSelector: { year, month in
            let monthStr = month < 10 ? "0\(month)" : "\(month)"
            self.btnTitle.setTitle(monthStr + "/\(year)", for: .normal)
        }).observeOn(MainScheduler.instance)
        .subscribe()
        .disposed(by: disposeBag)

        vm.currentMonth.subscribe(onNext: { month in
            self.vm.changeListDates(withMonth: month, year: self.vm.currentYear.value)
        }).disposed(by: disposeBag)
        
        vm.listCustomDates.subscribe(onNext: { _ in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    override func initUI() {
        super.initUI()
        collectionView.register(CalendarCollectionCell.self)
    }

    //Mark: Action of button
    @IBAction func btnOnTappedPreviousPage(_ sender: Any) {
        let currentMonth = vm.currentMonth.value
        let currentYear = vm.currentYear.value
        if currentMonth == 1 {
            vm.currentYear.accept(currentYear - 1)
            vm.currentMonth.accept(12)
        }else {
            vm.currentMonth.accept(currentMonth - 1)
        }
    }
    @IBAction func btnOnTappedNextPage(_ sender: Any) {
        let currentMonth = vm.currentMonth.value
        let currentYear = vm.currentYear.value
        if currentMonth == 12 {
            vm.currentYear.accept(currentYear + 1)
            vm.currentMonth.accept(1)
        }else {
            vm.currentMonth.accept(currentMonth + 1)
        }
    }
}

//Mark: Extension of Collection
extension CalendarVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PassStartDate, PassEndDate {
    
    func PassStartDate(string: String) {}
    func PassEndDate(string: String) {}
    func setTitle1(string: String) {title = "Thời gian bắt đầu" }
    func setTitle2(string: String) {title = "Thời gian kết thúc"}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.countOfListDate()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalendarCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configCell(vm.dateAtIndex(indexPath.row), isExpanded: vm.isExpanded)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = vm.isExpanded ? vm.heightOfExpandedCell : vm.heightOfNormalCell
        let width = collectionView.bounds.width / 7.0
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(vm.dateAtIndex(indexPath.row))
//        print(String(vm.dateAtIndex(indexPath.row).Date!) + "/" + String(vm.dateAtIndex(indexPath.row).Month!) + "/" + String(vm.dateAtIndex(indexPath.row).Year!))
//        print("other page")
        data = String(vm.dateAtIndex(indexPath.row).Date!) + "/" + String(vm.dateAtIndex(indexPath.row).Month!) + "/" + String(vm.dateAtIndex(indexPath.row).Year!)
        delegate1?.PassStartDate(string: data)
        delegate2?.PassEndDate(string: data)
       dismiss(animated: true, completion: nil)
        
    }
}


