//
//  RestaurantDetailViewController.swift
//  BobBob
//
//  Created by 박재영 on 2021/04/30.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var tier: UIImageView!
    @IBOutlet weak var bookmarked: UIButton!
    @IBOutlet weak var recommender: UILabel!
    @IBOutlet weak var cleanness: UIImageView!
    @IBOutlet weak var satisfaction: UIImageView!
    @IBOutlet weak var history: UIImageView!
    
    let defaults = UserDefaults.standard
    var arr: [Int] = []
    let ad = UIApplication.shared.delegate as? AppDelegate
    var index: Int = 0
    var isBookmarked : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        index = ad?.restaurantIndex ?? 0
        let restaurant = JsonHelper.RestaurantList[index]
        arr = defaults.array(forKey: "jjimList") as? [Int] ?? [Int]()
        setBookmark(index: index)
        setText(restaurant: restaurant)
    }
    
    func setBookmark(index: Int) {
        if (arr.firstIndex(of: index) != nil) {
            self.isBookmarked = true
            self.bookmarked.setImage(UIImage(named: "add_bookmark"), for: .normal)
        }
        else {
            self.isBookmarked = false
            self.bookmarked.setImage(UIImage(named: "clear_bookmark"), for: .normal)
        }
    }
    
    @IBAction func changeState(_ sender: UIButton) {
        if isBookmarked {
            arr.removeAll(where: { $0 == index })
            defaults.set(arr, forKey: "jjimList")
            self.bookmarked.setImage(UIImage(named: "clear_bookmark"), for: .normal)
            isBookmarked = false
        }
        else {
            arr.append(index)
            self.bookmarked.setImage(UIImage(named: "add_bookmark"), for: .normal)
            defaults.set(arr, forKey: "jjimList")
            isBookmarked = true
        }
    }

    func setText(restaurant: RestaurantData) {
        self.overview.text = restaurant.overview
        self.recommender.text = restaurant.curator
        let info = "\(restaurant.name)\n\(restaurant.address)\n\(restaurant.business_hour)" //텍스트를 한데 모아 파라미터로 전달
        self.content.attributedText = setColor(str: info)
        self.foodImage.image = UIImage(named: String(restaurant.index))
        self.tier.image = UIImage(named: restaurant.tier)
        self.cleanness.image = UIImage(named: restaurant.cleanness)
        self.satisfaction.image = UIImage(named: restaurant.satisfaction)
        self.history.image = UIImage(named: restaurant.history)
    }

    func setColor(str: String) -> NSMutableAttributedString {
        let attributedStr = NSMutableAttributedString(string: str)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (str as NSString).range(of: "휴무")) //휴무라는 글자는 빨간색으로
        // 설정이 적용된 text를 label의 attributedText에 저장
        return attributedStr
    }
}
