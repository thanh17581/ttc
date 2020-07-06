//
//  WriteAbsentRequestLetterVC.swift
//  TTCEasy
//
//  Created by Apple on 6/30/20.
//  Copyright © 2020 TTC Solutions VietNam. All rights reserved.
//

import UIKit
import STPopup
import MobileCoreServices
import Photos

extension WriteAbsentRequestLetterVC: PassStartDate, PassEndDate {
    func PassStartDate(string: String) {
        tfStartDate.text = string
    }
    func PassEndDate(string: String) {
        tfEndDate.text = string
    }
    func setTitle1(string: String) {}
    func setTitle2(string: String) {}
}
class tableViewCell: UITableViewCell {}

class WriteAbsentRequestLetterVC: BaseVC {

    //Mark: Properties
    
    @IBOutlet weak var btnUploadAttachedFile: UIButton!
    @IBOutlet weak var btnDaySessionOfEndDate: UIButton!
    @IBOutlet weak var btnDaySessionOfStartDate: UIButton!
    @IBOutlet weak var btnKindOfDate: UIButton!
    @IBOutlet weak var tfAttachedFile: UITextField!
    @IBOutlet weak var lblReasonAbsent: UILabel!
    @IBOutlet weak var tfReasonAbsent: UITextField!
    @IBOutlet weak var lblDaySessionOfEndDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblDaySessionOfStartDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var tfDaySessionOfEndDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var tfDaySessionOfStartDate: UITextField!
    @IBOutlet weak var btnEndDateCalendar: UIButton!
    @IBOutlet weak var btnStartDateCalendar: UIButton!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var tfStatus: UITextField!
    @IBOutlet weak var lblTextWarning: UILabel!
    @IBOutlet weak var lblKindOfDate: UILabel!
    @IBOutlet weak var lblStaff: UILabel!
    @IBOutlet weak var tfKindOfDate: UITextField!
    @IBOutlet weak var tfStaffInformation: UITextField!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var lblInfoImage1: UILabel!
    @IBOutlet weak var lblInfoImage2: UILabel!
    @IBOutlet weak var lblInfoImage3: UILabel!
    @IBOutlet weak var lblInfoImage4: UILabel!
    @IBOutlet weak var lblInfoImage5: UILabel!
    @IBOutlet weak var btnRemoveInfoImage1: UIButton!
    @IBOutlet weak var btnRemoveInfoImage2: UIButton!
    @IBOutlet weak var btnRemoveInfoImage3: UIButton!
    @IBOutlet weak var btnRemoveInfoImage4: UIButton!
    @IBOutlet weak var btnRemoveInfoImage5: UIButton!
    
    
    //Mark: Create delegate for calendar
    var delegate1 : PassStartDate?
    var delegate2 : PassEndDate?
    
    //Mark: Create for day session drop down
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UITextField()
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        lblStaff.text = "Nhân viên (*)"
        lblStaff.font = lblStaff.font.withSize(13)
        lblStaff.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblKindOfDate.text = "Loại ngày nghỉ (*)"
        lblKindOfDate.font = lblKindOfDate.font.withSize(13)
        lblKindOfDate.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblDaySessionOfEndDate.text = "Loại ca (*)"
        lblDaySessionOfEndDate.font = lblDaySessionOfEndDate.font.withSize(13)
        lblDaySessionOfStartDate.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblDaySessionOfEndDate.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblStartDate.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblEndDate.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblReasonAbsent.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblStatus.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        lblStatus.text = "Tính lương"
        lblStatus.font = lblStatus.font.withSize(13)
        lblDaySessionOfStartDate.text = "Loại ca (*)"
        lblDaySessionOfStartDate.font = lblDaySessionOfStartDate.font.withSize(13)
        lblStartDate.text = "Thời gian bắt đầu (*)"
        lblStartDate.font = lblStartDate.font.withSize(13)
        lblEndDate.text = "Thời gian kết thúc (*)"
        lblEndDate.font = lblEndDate.font.withSize(13)
        lblReasonAbsent.text = "Nhập Lý do (*)"
        lblReasonAbsent.font = lblReasonAbsent.font.withSize(13)
        lblTextWarning.font = lblTextWarning.font.withSize(12)
        lblTextWarning.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        btnAccept.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        btnAccept.cornerRadius = 20
        btnAccept.setTitle("TẠO ĐƠN", for: .normal)
        btnAccept.titleLabel?.font.withSize(12)
        btnAccept.setTitleColor(UIColor.white, for: .normal)
        tfAttachedFile.text = "Bạn có thể chọn 5 file đính kèm"
        tfAttachedFile.isEnabled = false
        
        self.navigationController?.navigationBar.isHidden = true
        self.tfKindOfDate.isUserInteractionEnabled = false
        self.tfDaySessionOfStartDate.isUserInteractionEnabled = false
        self.tfDaySessionOfEndDate.isUserInteractionEnabled = false
        self.tfStatus.isUserInteractionEnabled = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(tableViewCell.self, forCellReuseIdentifier: "Cell")
        img1.isHidden = true
        img2.isHidden = true
        img3.isHidden = true
        img4.isHidden = true
        img5.isHidden = true
        lblInfoImage1.isHidden = true
        lblInfoImage2.isHidden = true
        lblInfoImage3.isHidden = true
        lblInfoImage4.isHidden = true
        lblInfoImage5.isHidden = true
        btnRemoveInfoImage1.isHidden = true
        btnRemoveInfoImage2.isHidden = true
        btnRemoveInfoImage3.isHidden = true
        btnRemoveInfoImage4.isHidden = true
        btnRemoveInfoImage5.isHidden = true
    }

    @IBAction func OnStartDateTapped(_ sender: Any) {
        let calendavc = CalendarVC()
        let vc = STPopupController(rootViewController: calendavc)
        calendavc.delegate1 = self
        calendavc.setTitle1(string: "Thời gian bắt đầu")
        vc.present(in: self, completion: nil)
    }
    @IBAction func OnEnđateTapped(_ sender: Any) {
        let calendavc = CalendarVC()
        let vc = STPopupController(rootViewController: calendavc)
        calendavc.delegate2 = self
        calendavc.setTitle2(string: "Thời gian kết thúc")
        vc.present(in: self, completion: nil)
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        },completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        },completion: nil)
    }

    @IBAction func OnKindOfDateButtonTapped(_ sender: Any) {
        print("Loại ngày nghỉ")
        dataSource = ["Ngày nghỉ", "Ngày đi làm", "Ngày lễ","Ngày cuối tuần"]
        selectedButton = tfKindOfDate
        addTransparentView(frames: tfKindOfDate.frame)
    }
    @IBAction func OnDaySessionOfStartDateButtonTapped(_ sender: Any) {
        print("Loại ca của ngày bắt đầu")
        dataSource = ["Thanh", "Dat", "Thanh"]
        selectedButton = tfDaySessionOfStartDate
        addTransparentView(frames: tfDaySessionOfStartDate.frame)
    }
    @IBAction func OnDaySessionOfEndDateButtonTapped(_ sender: Any) {
        print("Loại ca của ngày kết thúc")
        dataSource = ["Dat", "Thanh", "Dat"]
        selectedButton = tfDaySessionOfEndDate
        addTransparentView(frames: tfDaySessionOfEndDate.frame)
    }
    @IBAction func OnUploadAttachedFileButtonTapped(_ sender: Any) {
        print("Now it is your turn!!!!!!!!!!!!!!!!!!")
        if img5.image == nil {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypeData),String(kUTTypePDF), String(kUTTypePNG), String(kUTTypeJPEG), String(kUTTypeImage)], in: .import)
        let actionSheet = UIAlertController(title: "Photo Source", message: "Let's choose a photo source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Choose file", style: .default, handler: {(action:UIAlertAction) in
            importMenu.delegate = self
            if #available(iOS 11.0, *) {
                importMenu.allowsMultipleSelection = true
            } else {
                print("Bạn phải cập nhật hệ thống bản mới nhất để có thể sử dụng được chức năng này / You have to update your operating system upto IOS 11.0 to choose multiple file")
            }
            self.present(importMenu, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera không sẵn sàng để sử dụng / Camera is not available to use")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo from library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.dismiss(animated: true, completion: nil)
        }))
            self.present(actionSheet, animated: true, completion: nil)
        } else {
            let actionSheet = UIAlertController(title: "Thông báo", message: "Bạn chỉ có thể tải 5 files. Bạn không thể chọn nhiều file hơn để đăng tải", preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    @IBAction func OnAcceptButtonTapped(_ sender: Any) {
        print("Đơn điền đầy đủ r, bấm nút r nghỉ thôiiiii")
    }
    @IBAction func OnRemoveImage1Tapped(_ sender: Any) {
        img1.image = nil
        if img1.image == nil {
            if img5.image != nil && img4.image != nil && img3.image != nil && img2.image != nil {
                img1.image = img2.image
                img2.image = img3.image
                img3.image = img4.image
                img4.image = img5.image
                img5.image = nil
                btnRemoveInfoImage5.isHidden = true
                lblInfoImage1.text = lblInfoImage2.text
                lblInfoImage2.text = lblInfoImage3.text
                lblInfoImage3.text = lblInfoImage4.text
                lblInfoImage4.text = lblInfoImage5.text
                lblInfoImage5.isHidden = true
            } else if img4.image != nil && img3.image != nil && img2.image != nil {
                img1.image = img2.image
                img2.image = img3.image
                img3.image = img4.image
                img4.image = nil
                img5.image = nil
                btnRemoveInfoImage4.isHidden = true
                btnRemoveInfoImage5.isHidden = true
                lblInfoImage1.text = lblInfoImage2.text
                lblInfoImage2.text = lblInfoImage3.text
                lblInfoImage3.text = lblInfoImage4.text
                lblInfoImage4.isHidden = true
                lblInfoImage5.isHidden = true
            } else if img3.image != nil && img2.image != nil {
                img1.image = img2.image
                img2.image = img3.image
                img3.image = nil
                img4.image = nil
                img5.image = nil
                btnRemoveInfoImage3.isHidden = true
                btnRemoveInfoImage4.isHidden = true
                btnRemoveInfoImage5.isHidden = true
                lblInfoImage1.text = lblInfoImage2.text
                lblInfoImage2.text = lblInfoImage3.text
                lblInfoImage3.isHidden = true
                lblInfoImage4.isHidden = true
                lblInfoImage5.isHidden = true
            } else if img2.image != nil {
                img1.image = img2.image
                img2.image = nil
                img3.image = nil
                img4.image = nil
                img5.image = nil
                btnRemoveInfoImage2.isHidden = true
                btnRemoveInfoImage3.isHidden = true
                btnRemoveInfoImage4.isHidden = true
                btnRemoveInfoImage5.isHidden = true
                lblInfoImage1.text = lblInfoImage2.text
                lblInfoImage2.isHidden = true
                lblInfoImage3.isHidden = true
                lblInfoImage4.isHidden = true
                lblInfoImage5.isHidden = true
            } else {
                img1.isHidden = true
                btnRemoveInfoImage1.isHidden = true
                lblInfoImage1.isHidden = true
            }
        }
        else {
            btnRemoveInfoImage1.isHidden = true
            lblInfoImage1.isHidden = true
        }
    }
    @IBAction func OnRemoveImage2Tapped(_ sender: Any) {
        img2.image = nil
        btnRemoveInfoImage2.isHidden = true
        lblInfoImage2.isHidden = true
    }
    @IBAction func OnRemoveImage3Tapped(_ sender: Any) {
        img3.image = nil
        btnRemoveInfoImage3.isHidden = true
        lblInfoImage3.isHidden = true
    }
    @IBAction func OnRemoveImage4Tapped(_ sender: Any) {
        img4.image = nil
        btnRemoveInfoImage4.isHidden = true
        lblInfoImage4.isHidden = true
    }
    @IBAction func OnRemoveImage5Tapped(_ sender: Any) {
        img5.image = nil
        btnRemoveInfoImage5.isHidden = true
        lblInfoImage5.isHidden = true
    }
}
extension WriteAbsentRequestLetterVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.text = dataSource[indexPath.row]
        removeTransparentView()
    }
}
extension WriteAbsentRequestLetterVC: UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        if img1.image == nil {
            img1.isHidden = false
            if url.pathExtension == "docx" {
                img1.image = #imageLiteral(resourceName: "ic_word_file")
            } else if url.pathExtension == "pdf" {
                img1.image = #imageLiteral(resourceName: "ic_pdf_file")
            } else if url.pathExtension == "jpg" || url.pathExtension == "png" {
                print("zz")
            }
            if url.lastPathComponent.count <= 20 {
                lblInfoImage1.text = url.lastPathComponent
            } else {
                let str = url.lastPathComponent
                lblInfoImage1.text = str.substring(to: 16) + "..." + url.pathExtension
            }
            lblInfoImage1.isHidden = false
            btnRemoveInfoImage1.isHidden = false
        } else if img2.image == nil {
            if url.pathExtension == "docx" {
                img2.image = #imageLiteral(resourceName: "ic_word_file")
            } else if url.pathExtension == "pdf" {
                img2.image = #imageLiteral(resourceName: "ic_pdf_file")
            } else if url.pathExtension == "jpg" || url.pathExtension == "png" {
                print("zz")
            }
            img2.isHidden = false
            if url.lastPathComponent.count <= 20 {
                lblInfoImage2.text = url.lastPathComponent
            } else {
                let str = url.lastPathComponent
                lblInfoImage2.text = str.substring(to: 16) + "..." + url.pathExtension
            }
            
            lblInfoImage2.isHidden = false
            btnRemoveInfoImage2.isHidden = false
        } else if img3.image == nil {
            if url.pathExtension == "docx" {
                img3.image = #imageLiteral(resourceName: "ic_word_file")
            } else if url.pathExtension == "pdf" {
                img3.image = #imageLiteral(resourceName: "ic_pdf_file")
            } else if url.pathExtension == "jpg" || url.pathExtension == "png" {
                print("zz")
            }
            img3.isHidden = false
            if url.lastPathComponent.count <= 20 {
                lblInfoImage3.text = url.lastPathComponent
            } else {
                let str = url.lastPathComponent
                lblInfoImage3.text = str.substring(to: 16) + "..." + url.pathExtension
            }
            lblInfoImage3.isHidden = false
            btnRemoveInfoImage3.isHidden = false
        } else if img4.image == nil {
            if url.pathExtension == "docx" {
                img4.image = #imageLiteral(resourceName: "ic_word_file")
            } else if url.pathExtension == "pdf" {
                img4.image = #imageLiteral(resourceName: "ic_pdf_file")
            } else if url.pathExtension == "jpg" || url.pathExtension == "png" {
                print("zz")
            }
            img4.isHidden = false
            if url.lastPathComponent.count <= 20 {
                lblInfoImage4.text = url.lastPathComponent
            } else {
                let str = url.lastPathComponent
                lblInfoImage4.text = str.substring(to: 16) + "..." + url.pathExtension
            }
            lblInfoImage4.isHidden = false
            btnRemoveInfoImage4.isHidden = false
        } else if img5.image == nil{
            if url.pathExtension == "docx" {
                img5.image = #imageLiteral(resourceName: "ic_word_file")
            } else if url.pathExtension == "pdf" {
                img5.image = #imageLiteral(resourceName: "ic_pdf_file")
            } else if url.pathExtension == "jpg" || url.pathExtension == "png" {
                print("zz")
            }
            img5.isHidden = false
            if url.lastPathComponent.count <= 20 {
                lblInfoImage5.text = url.lastPathComponent
            } else {
                let str = url.lastPathComponent
                lblInfoImage5.text = str.substring(to: 16) + "..." + url.pathExtension
            }
            lblInfoImage5.isHidden = false
            btnRemoveInfoImage5.isHidden = false
        }
        if img1.image == nil {
            tfAttachedFile.text = "Bạn có thể chọn 5 file đính kèm"
        } else if img2.image == nil {
            tfAttachedFile.text = "Bạn có thể chọn 4 file đính kèm"
        } else if img3.image == nil {
            tfAttachedFile.text = "Bạn có thể chọn 3 file đính kèm"
        } else if img4.image == nil {
            tfAttachedFile.text = "Bạn có thể chọn 2 file đính kèm"
        } else if img5.image == nil {
            tfAttachedFile.text = "Bạn có thể chọn 1 file đính kèm"
        } else {
            tfAttachedFile.text = "Bạn không thể chọn thêm file đính kèm"
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        if #available(iOS 11.0, *) {
//            let url = info[UIImagePickerController.InfoKey.imageURL]!
//            print(url)
//            print(url)
//        } else {
//            print("you have to update your operating system to 11.0 or newest")
//        }
        if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
            print((asset?.value(forKey: "filename")!)!)
            if img1.image == nil {
                img1.image = image
                img1.isHidden = false
                lblInfoImage1.text = (((asset?.value(forKey: "filename")!)!) as! String)
                lblInfoImage1.isHidden = false
                btnRemoveInfoImage1.isHidden = false
                tfAttachedFile.text = "Bạn có thể chọn 4 file đính kèm"
    //            btnAccept.topAnchor.constraint(equalTo: lblInfoImage1.bottomAnchor, constant: 26).isActive = true
            } else if img2.image == nil {
                img2.image = image
                img2.isHidden = false
                lblInfoImage2.text = (((asset?.value(forKey: "filename")!)!) as! String)
                lblInfoImage2.isHidden = false
                btnRemoveInfoImage2.isHidden = false
                tfAttachedFile.text = "Bạn có thể chọn 3 file đính kèm"
    //            btnAccept.topAnchor.constraint(equalTo: lblInfoImage1.bottomAnchor, constant: 26).isActive = true
            } else if img3.image == nil {
                img3.image = image
                img3.isHidden = false
                lblInfoImage3.text = (((asset?.value(forKey: "filename")!)!) as! String)
                lblInfoImage3.isHidden = false
                btnRemoveInfoImage3.isHidden = false
                tfAttachedFile.text = "Bạn có thể chọn 2 file đính kèm"
    //            btnAccept.topAnchor.constraint(equalTo: lblInfoImage1.bottomAnchor, constant: 26).isActive = true
            } else if img4.image == nil {
                img4.image = image
                img4.isHidden = false
                lblInfoImage4.text = (((asset?.value(forKey: "filename")!)!) as! String)
                lblInfoImage4.isHidden = false
                btnRemoveInfoImage4.isHidden = false
                tfAttachedFile.text = "Bạn có thể chọn 1 file đính kèm"
    //            btnAccept.topAnchor.constraint(equalTo: lblInfoImage1.bottomAnchor, constant: 26).isActive = true
            } else if img5.image == nil{
                img5.image = image
                img5.isHidden = false
                lblInfoImage5.text = (((asset?.value(forKey: "filename")!)!) as! String)
                lblInfoImage5.isHidden = false
                btnRemoveInfoImage5.isHidden = false
                tfAttachedFile.text = "Bạn có thể chọn 0 file đính kèm"
    //            btnAccept.topAnchor.constraint(equalTo: lblInfoImage5.bottomAnchor, constant: 26).isActive = true
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
