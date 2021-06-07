//
//  profileViewController.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/04/26.
//

import UIKit
import MobileCoreServices

class profileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    let imagePicker : UIImagePickerController! = UIImagePickerController()
    var captureImage : UIImage!
    var flagSave = false
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.hidesBarsOnTap = false
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        self.profileImage.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        print("asd")
    }
    
    @objc func tappedProfile(_ sender: Any) {
        // 전반부) 원하는 소스 타입을 선택할 수 있는 액션 시트 구현
        let msg = "프로필 이미지를 읽어올 장소를 선택하세요."
        let sheet = UIAlertController(title: msg, message: nil, preferredStyle: .actionSheet)
      
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
/*
        sheet.addAction(UIAlertAction(title: "저장된 앨범", style: .default) { (_) in
            let picker = UIImagePickerController()
            picker.sourceType = .savedPhotosAlbum // 시뮬에서 작동안됨 - 실기기로 테스트시 성공
            picker.allowsEditing = true
            
            picker.delegate = self
            self.present(picker,animated: true)
        })
*/
        sheet.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) { (_) in
            selectLibrary(src: .photoLibrary) // 포토 라이브러리에서 이미지 선택하기
        })
        
        sheet.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
            //selectLibrary(src: .camera) // 카메라에서 이미지 촬영하기
            let picker = UIImagePickerController()
            picker.sourceType = .camera // 시뮬에서 작동안됨 - 실기기로 테스트시 성공
            picker.allowsEditing = true
            
            picker.delegate = self
            self.present(picker,animated: true)
            
        })
        
        self.present(sheet, animated: false)
      
        // 후반부) 전달된 소스 타입에 맞게 이미지 피커 창을 여는 내부 함수
        func selectLibrary(src: UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(src) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
          
                self.present(picker, animated: false)
            } else {
                self.alert("사용할 수 없는 타입입니다.")
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 사용자가 이미지를 클릭하였을 때 실행될 델리게이트 메소드
        let rawVal = UIImagePickerController.InfoKey.originalImage.rawValue
        
        if let img = info[UIImagePickerController.InfoKey(rawValue: rawVal)] as? UIImage {
            self.profileImage.image = img
        }
        
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
   
    
    
    
    func alert(_ message : String, completion : (()->Void)? = nil) {
        
        // 메인 스레드에서 실행하도록 변경
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?() // completion 매개변수의 값이 nil이 아닐 때에만 실행되도록
            }
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
    
}
