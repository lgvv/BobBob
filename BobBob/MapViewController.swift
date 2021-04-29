//
//  MapViewController.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/04/26.
//

import UIKit
import MapKit
import Foundation


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var test = json_test()
        test.readJson()
        
        // 내비게이션 바 숨김 처리
        self.navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self // 상수 로케이션 메니저의 델리게이트를 셀로프 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치 데이터를 추적하기 위해 사용자에게 승인을 요구하는 코드
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        // 현재위치는 실제 디바이스가 아니면 시뮬레이터 - 피쳐 - 로케이션 - 커스텀 통해 설정해야 해
        myMap.showsUserLocation = true // 위치 보기 값을 트루로 설정
        
        /*
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                  }
              } catch {
              }
        }
        
        for i in 1...9{
            
        }
         */
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func updateMyLocation(_ sender: Any) {
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true // 위치 보기 값을 트루로 설정
    }
    
    
    func goLocation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double) -> CLLocationCoordinate2D {
        // 위도와 경도로 원하는 위치를 표시하기 위한 함수
        
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) // 위도 값과 경도 값을 매개변수로 하여 함수호출하여 그것을 받는다.
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 범위 값을 매개변수로 하여 함수를 호출하고 리턴값을 받는다
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // 위의 두 정보를 매개변수로 하여 리턴값을 받는다.
        myMap.setRegion(pRegion, animated: true) // 함수 호출!
        
        return pLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 위치가 업데이트 되었을 때 지도에 위치를 나타내기 위한 함수
        let pLocation = locations.last // 위치가 업데이트 되면 먼저 마지막 위치 값을 찾아낸다
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 마지막 위치의 위도와 경도 값을 가지고 앞에서 만든 goLocation 함수를 호출한다. 이때 delta 값은 지도의 크기를 정하는데, 값이 작을수록 확대되는 효과가 있습니다. delta 0.01로 하였으니 1의 값보다 지도를 100배로 확대해소 보여줄 것입니다. _ 표시는 워닝이나 에러를 막기 위한 코드
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            /*
             플레이스 마크 값의 첫 부분만 pm상수로 받는다.
             country 나라
             locality 지역
             thoroughfare 도로
             
             나라 지역 도로 --> 공백넣어 읽기 쉽게하기
             */
            
            (placemarks, error) -> Void in
            let pm = placemarks!.first // 플레이스마크 값의 첫 부분만 pm상수로 대입한다
            let country = pm!.country // pm상수에서 나라 값을 컨트로 상수에 대입
            var address: String = country! // 문자열 address에 country 상수의 값을 대입합니다.
            if pm!.locality != nil { // pm 상수에서 도로 값이 존재하면 adress 문자열에 추가합니다
                address += " " // 공백넣어서 읽기 쉽게 하려고.
                address += pm!.thoroughfare!
            }
            
            
        }) // 위도와 경도값을 갖고 역으로 주소를 찾아보겠다. 핸들러의 익명함수를 추가로 준비해고 익명함수로 처리한다
        
        locationManager.stopUpdatingLocation() // 마지막으로 위치가 업데이트되는 것을 멈추게 한다.
    }
    
    func setAnnotation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double, title strTitle : String, subtitle strSubtitle : String) {
        let annotation = MKPointAnnotation() // 핀을 설취하기 위해 mk포인트어노테이션 함수 호출하여 리턴 값을 받는다.
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span) // 어노테이션의 쿠디네이트 값을 고로케이션 함수로부터 2D형태로 받어야하는데, 이를 위해서는 goLocation 함수에 리턴값이 있게 수정해야 한다.
        
        //annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle // 핀의 타이틀
        annotation.subtitle = strSubtitle // 핀의 서브타이틀
        myMap.addAnnotation(annotation) // 맵 뷰에 변수 어노테이션 값을 추가
    }
    
    @IBAction func unwind(_ segue : UIStoryboardSegue) { // unwind 세그웨이 프로그래밍적으로 구현 - 왜냐하면 바로 이전화면이 아니라 더더 이전화면을 건너가야하는 경우도 생기니까.
        // 단지 프로필 화면으로 되돌아오기 위한 표식 역할만 할 뿐이므로 아무 내용도 작성하지 않는다
    }

}
