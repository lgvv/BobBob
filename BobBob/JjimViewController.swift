//
//  JjimViewController.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/04/26.
//

import UIKit


class JjimViewController: UIViewController {
    @IBOutlet weak var rtableView: UITableView!
    let defaults = UserDefaults.standard
    var favorateList : [RestaurantData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnTap = false
        
        setList()
        rtableView.dataSource = self
        rtableView.delegate = self
        rtableView.separatorStyle = .none// 테이블 사이의 구분선이 없어짐
    }
    
    func setList() {
        let arr = defaults.array(forKey: "jjimList") as? [Int] ?? [Int]()
        for i in arr {
            favorateList.append(JsonHelper.RestaurantList[i])
        }
    }
    @IBAction func gg(_ sender: Any) {
        /*
        var objectToShare = [String]()
        /*
         전달하고자 하는 내용을 배열에 넣어서
         */
        objectToShare.append("""
                [BobBob] 
                등록을 원하시는 경우 아래의 코드를 복사해 가족으로 등록해주세요!
                코드 :
                """) // 여러줄로 나눠쓰는 경우는 스위프트에서는 """ 세개 이용하며 줄바꿈도 필수적으로 해야한다..
        
        let activityVC = UIActivityViewController(activityItems : objectToShare, applicationActivities: nil)
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
        //activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
         */
        print("AD")
    }
    
}

extension JjimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rtableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellAttr
        cell.img.image = UIImage(named: String(favorateList[indexPath.row].index))
        cell.title.text = favorateList[indexPath.row].name
        cell.addr.text = favorateList[indexPath.row].address
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var objectToShare = [String]()
        /*
         전달하고자 하는 내용을 배열에 넣어서
         */
        objectToShare.append("""
                [BobBob]에서 당신을 초대합니다!
                \(favorateList[indexPath.row].name)
                주소 : \(favorateList[indexPath.row].address)
                """) // 여러줄로 나눠쓰는 경우는 스위프트에서는 """ 세개 이용하며 줄바꿈도 필수적으로 해야한다..
        
        let activityVC = UIActivityViewController(activityItems : objectToShare, applicationActivities: nil)

        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    /*func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("ASDvv")
    }*/
}
