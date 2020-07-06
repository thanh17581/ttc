//
//  HomeVC.swift
//  TTCEasy
//
//  Created by TrungNV on 6/5/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: BaseVC {
    @IBOutlet weak var heightOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var icArrow: UIImageView!

    let vm = HomeVM()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initData() {
        super.initData()
    }

    override func bindData() {
        super.bindData()
        Observable.combineLatest(vm.currentYear, vm.currentMonth, resultSelector: { year, month in
            let monthStr = month < 10 ? "0\(month)" : "\(month)"
            self.btnTitle.setTitle("Chấm công " + monthStr + "/\(year)", for: .normal)
        }).observeOn(MainScheduler.instance)
        .subscribe()
        .disposed(by: disposeBag)


        vm.currentMonth.subscribe(onNext: { month in
            self.vm.changeListDates(withMonth: month, year: self.vm.currentYear.value)
        }).disposed(by: disposeBag)

        heightOfCollectionView.rx_constraint.distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: { constant in
                self.vm.isExpanded = constant == self.vm.heightOfNormalCollection ? false : true
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)


        vm.listCustomDates.subscribe(onNext: { _ in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }

    override func initUI() {
        super.initUI()
        collectionView.register(CalendarCollectionCell.self)
        initGestures()
    }

    func initGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        swipeView.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if self.heightOfCollectionView.constant == vm.heightOfNormalCollection {
            self.icArrow.transform = CGAffineTransform(rotationAngle: .pi)
            self.heightOfCollectionView.constant = vm.heightOfExpandedCollection
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }else{
            self.icArrow.transform = .identity
            self.heightOfCollectionView.constant = vm.heightOfNormalCollection
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @IBAction func backDateAction(_ sender: Any) {
        let currentMonth = vm.currentMonth.value
        let currentYear = vm.currentYear.value
        if currentMonth == 1 {
            vm.currentYear.accept(currentYear - 1)
            vm.currentMonth.accept(12)
        }else {
            vm.currentMonth.accept(currentMonth - 1)
        }
    }

    @IBAction func nextDateAction(_ sender: Any) {
        let currentMonth = vm.currentMonth.value
        let currentYear = vm.currentYear.value
        if currentMonth == 12 {
            vm.currentYear.accept(currentYear + 1)
            vm.currentMonth.accept(1)
        }else {
            vm.currentMonth.accept(currentMonth +    1)
        }
    }

}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
}
