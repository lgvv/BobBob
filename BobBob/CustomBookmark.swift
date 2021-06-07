//
//  CustomBookmark.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/06/05.
//

import UIKit

class CustomBookmark : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var CSrtableView: UITableView!
    var savedImgIdx: [Int] = []
    var names: [String] = []
    var address: [String] = []
    let defaults = UserDefaults.standard
    let ad = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        CSrtableView.delegate = self
        CSrtableView.dataSource = self
        CSrtableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        savedImgIdx = defaults.array(forKey: "customBookmark") as? [Int] ?? [Int]()
        names = defaults.array(forKey: "restaurantNames") as? [String] ?? [String]()
        address = defaults.array(forKey: "restaurantAddress") as? [String] ?? [String]()
        CSrtableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CSrtableView.dequeueReusableCell(withIdentifier: "CScell") as! CSCellAttr
        cell.CStitle.text = names[indexPath.row]
        cell.CSaddr.text = address[indexPath.row]
        if let image = getSavedImage(named: String(savedImgIdx[indexPath.row])) {
            cell.CSimg.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            CSrtableView.beginUpdates()
            savedImgIdx.remove(at: indexPath.row)
            names.remove(at: indexPath.row)
            address.remove(at: indexPath.row)
            CSrtableView.deleteRows(at: [indexPath],with: UITableView.RowAnimation.automatic)
            CSrtableView.endUpdates()
            defaults.set(savedImgIdx, forKey: "customBookmark")
            defaults.set(names, forKey: "restaurantNames")
            defaults.set(address, forKey: "restaurantAddress")
        }
    }
    
    
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    @IBAction func addBtn(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CSaddPageVC") else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}
