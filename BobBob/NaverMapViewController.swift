//
//  NaverMapViewController.swift
//  BobBob
//
//  Created by 박재영 on 2021/04/30.
//

import UIKit
import NMapsMap

class NaverMapViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet weak var naverMap: NMFMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var places: [hotplace] = []
    
    struct hotplace {
        let name: String
        let lat: Double
        let lng: Double
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
        }
    }
    
    // MARK : 위치 허용 선택했을 때 처리
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined :
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            self.firstSetting()
            break
        case .authorizedAlways:
            self.firstSetting()
            break
        case .restricted :
            break
        case .denied :
            break
        default:
            break
        }
    }
    
    func firstSetting(){
        self.currentLocation = locationManager.location
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude))
        naverMap.moveCamera(cameraUpdate) // 위치 업데이트
        naverMap.positionMode = .direction // 위치 추적 모드
        hardCoding() // 검색 가능 좌표 하드코딩
        for r in JsonHelper.RestaurantList {    // 화면에 식당 표시
            setPoint(data: r)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){ //다른 곳 터치시 키보드 숨기는 메소드
         self.view.endEditing(true)
   }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self // seach bar delegate
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 0.7))
        locationManager.delegate = self // 상수 로케이션 메니저의 델리게이트를 셀프로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치 데이터를 추적하기 위해 사용자에게 승인을 요구하는 코드
        locationManager.startUpdatingLocation() // 위치 업데이트 시작

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 기능이 꺼져있음", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 제공 불가", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        // 이미 허용인 경우 처리
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.firstSetting()
        }
    }
    
    func setPoint(data: RestaurantData) {
        let marker = NMFMarker()
        marker.iconImage = NMFOverlayImage(name: data.tier)
        marker.position = NMGLatLng(lat: data.latitudeValue, lng: data.longitudeValue)
        marker.height = 30
        marker.width = 30
        marker.minZoom = 11
        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
            let ad = UIApplication.shared.delegate as? AppDelegate
            ad?.restaurantIndex = data.index
            
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantVC")
            vcName?.modalTransitionStyle = .coverVertical
            self.present(vcName!, animated: true, completion: nil)
            return true
        }
        marker.mapView = naverMap
    }
    
    func movePoint(target: String) {
        for i in places {
            if i.name.contains(target) {
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: i.lat, lng: i.lng))
                naverMap.moveCamera(cameraUpdate)
                return
            }
        }
    }
    
    func hardCoding() {
        places.append(hotplace(name: "강남역", lat: 37.49827494113204, lng: 127.02765994046446))
        places.append(hotplace(name: "홍대입구,홍익대학교", lat: 37.55704755866706, lng: 126.92418218433565))
        places.append(hotplace(name: "건대입구,건국대학교", lat: 37.54012952552766, lng: 127.07046153451093))
        places.append(hotplace(name: "혜화역,대학로", lat: 37.58237403668897, lng: 127.00180716744786))
        places.append(hotplace(name: "판교", lat: 37.360288612049594, lng: 127.10474678470999))

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movePoint(target: self.searchBar.text ?? "")
        self.searchBar.text = ""
        self.view.endEditing(true)
    }
    
    @IBAction func updateMyLocation(_ sender: UIButton) {
        naverMap.positionMode = .direction
    }
}

