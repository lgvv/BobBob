//
//  JeboViewController.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/04/26.
//

import UIKit
import MobileCoreServices

class JeboViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var jebo_addr: UITextField!
    @IBOutlet var img_preview: UIImageView!
    
    let imagePicker : UIImagePickerController! = UIImagePickerController()
    var captureImage : UIImage!
    var flagSave = false
    
    @IBAction func done(_ sender: Any) {
        self.performSegue(withIdentifier: "unwind", sender: self)
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

        
    }
}
