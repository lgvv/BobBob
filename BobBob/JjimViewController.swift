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
    
}
