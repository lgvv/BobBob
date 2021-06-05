//
//  CustomBookmark.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/06/05.
//

import UIKit

class CustomBookmark : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var CSrtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CSrtableView.delegate = self
        CSrtableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CSrtableView.dequeueReusableCell(withIdentifier: "CScell") as! CSCellAttr
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    @IBAction func addBtn(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CSaddPageVC") else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}
