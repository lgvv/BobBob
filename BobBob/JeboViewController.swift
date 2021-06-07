//
//  JeboViewController.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/04/26.
//

import UIKit
import MobileCoreServices
import MessageUI

class JeboViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var jebo_addr: UITextField!
    @IBOutlet var img_preview: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    let imagePicker : UIImagePickerController! = UIImagePickerController()
    var captureImage : UIImage!
    var flagSave = false
    
    @IBAction func done(_ sender: Any) {
//        self.performSegue(withIdentifier: "unwind", sender: self)
//        sendMail()
        let alert = UIAlertController(title: "안내", message: "맛집 제보가 완료되었습니다. \n소중한 의견 감사합니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func image_find(_ sender: Any) {
        if( UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagSave {
                UIImageWriteToSavedPhotosAlbum(captureImage,nil,nil,nil)
            }
        }
        
        img_preview.image = captureImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnTap = false
        hideKeyboard()
        
        //button.backgroundColor = .systemBlue
        //button.setTitle("이미지 추가하기", for: .normal)
        //button.setTitleColor(.white, for: .normal)
        
    }
    
    func hideKeyboard() {   //다른 곳 터치시 키보드 숨기는 메소드
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() { // 다른 곳 터치시 키보드 숨기는 메소드
        view.endEditing(true)
        navigationController?.isNavigationBarHidden = false
    }
    
//    func sendMail() {
//      if MFMailComposeViewController.canSendMail() {
//        let mail = MFMailComposeViewController()
//        mail.mailComposeDelegate = self;
//        mail.setToRecipients(["jyp13.jyp@icloud.com"])
//        mail.setSubject(name.text!)
//        mail.setMessageBody(jebo_addr.text!, isHTML: false)
//        let imageData : NSData = (self.img_preview.image ?? UIImage(named: "recommended"))!.pngData()! as NSData
//        mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
//        self.present(mail, animated: true, completion: nil)
//      }
//    }
    
    
}
