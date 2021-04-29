//
//  JjimViewController.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/04/26.
//

import UIKit


class JjimViewController: UITableViewController {
        
    //@IBOutlet var img: UIImageView!
    
    let cell = CellAttr()
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        
    

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // 우선 1인데 sql 활용하면서 바뀌어야 함
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104 // 프로그래밍적으로 변경해야 할 경우 테이블 뷰의 높이
    }
    
    
}
