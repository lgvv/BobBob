//
//  CSaddPage.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/06/06.
//

import UIKit


class CSaddPage : UIViewController {
    
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageview.backgroundColor = .secondarySystemBackground
        
        button.backgroundColor = .systemBlue
        button.setTitle("사진 찍기", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }

    @IBAction func didTapButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera // 시뮬에서 작동안됨 - 실기기로 테스트시 성공
        picker.allowsEditing = true
        
        picker.delegate = self
        present(picker,animated: true)
        
    }
}

extension CSaddPage : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        imageview.image = image
        
        
    }
    
}
