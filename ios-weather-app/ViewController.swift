//
//  ViewController.swift
//  ios-weather-app
//
//  Created by 허지인 on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLable: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true) // 버튼이 눌리면 키보드가 사라지도록
        }
    }
    
    func getCurrentWeather(cityName: String){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=59474a51ff2d81c4fa8b9f39791aea9b") else {return}
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { //서버로 데이터 요청
            data, response, error in
            guard let data = data, error == nil else {return} //요청이 성공하면 nil 반환
            let decoder = JSONDecoder() // json객체에서 데이터 유형의 인스턴스로 디코딩하는 객체
            let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data)
            debugPrint(weatherInformation)
        }.resume()
    }
    
    
}

