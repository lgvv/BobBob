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
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    let ad = UIApplication.shared.delegate as? AppDelegate
    var savedImgIdx: [Int] = []
    var names: [String] = []
    var address: [String] = []
    let defaults = UserDefaults.standard
    var lastIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageview.backgroundColor = .secondarySystemBackground
        
        //button.backgroundColor = .systemBlue
        //button.setTitle("사진 찍기", for: .normal)
        //button.setTitleColor(.white, for: .normal)
        hideKeyboard()
        savedImgIdx = defaults.array(forKey: "customBookmark") as? [Int] ?? [Int]()
        names = defaults.array(forKey: "restaurantNames") as? [String] ?? [String]()
        address = defaults.array(forKey: "restaurantAddress") as? [String] ?? [String]()
        
        if !savedImgIdx.isEmpty{
            lastIndex = savedImgIdx[savedImgIdx.index(before: savedImgIdx.endIndex)]
        }
    }
    @IBAction func done(_ sender: UIButton) {
        let alert = UIAlertController(title: "안내", message: "저장 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        refreshList()
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera // 시뮬에서 작동안됨 - 실기기로 테스트시 성공
        picker.allowsEditing = true
        
        picker.delegate = self
        present(picker,animated: true)
        
    }
    func refreshList() {
        lastIndex += 1
        savedImgIdx.append(lastIndex)
        names.append(nameField.text!)
        address.append(addressField.text!)
        saveImage(image: imageview.image!)
        defaults.set(savedImgIdx, forKey: "customBookmark")
        defaults.set(names, forKey: "restaurantNames")
        defaults.set(address, forKey: "restaurantAddress")
        print("이미지 저장함")
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(String(lastIndex)).png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
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
