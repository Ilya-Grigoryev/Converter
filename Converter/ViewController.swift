//
//  ViewController.swift
//  Converter
//
//  Created by Il'ya Grigorev on 06.06.2020.
//  Copyright © 2020 Il'ya Grigorev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//  Text fields:
    @IBOutlet weak var rubTF: UITextField!
    @IBOutlet weak var usdTF: UITextField!
    @IBOutlet weak var eurTF: UITextField!
    @IBOutlet weak var thbTF: UITextField!
    @IBOutlet weak var gbpTF: UITextField!
    @IBOutlet weak var chfTF: UITextField!
    @IBOutlet weak var jpyTF: UITextField!
    @IBOutlet weak var date: UILabel!
    
    var currenciesTF:[UITextField] { [rubTF, usdTF, eurTF, thbTF, gbpTF, chfTF, jpyTF] }

//  Currency ratios regarding usd:
    var rub: Double! //= 68.49
    var usd: Double! //= 1
    var eur: Double! //= 0.89
    var thb: Double! //= 31.49
    var gbp: Double! //= 0.79
    var chf: Double! //= 0.96
    var jpy: Double! //= 109.59

    var currencies:[Double] { [rub, usd, eur, thb, gbp, chf, jpy] }

    struct Rates: Decodable {
        let RUB: Double
        let USD: Double
        let EUR: Double
        let THB: Double
        let GBP: Double
        let CHF: Double
        let JPY: Double
    }
    struct ObjectLikeJson: Decodable {
        let base: String
        let date: String
        let rates: Rates
    }

    override func viewDidLoad() {
      super.viewDidLoad()

        let url = URL(string: "https://api.exchangeratesapi.io/latest?base=USD")

        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else{ return }

            do {
                let objectLikeJson = try JSONDecoder().decode(ObjectLikeJson.self, from: data)

                self.rub = objectLikeJson.rates.RUB
                self.usd = objectLikeJson.rates.USD
                self.eur = objectLikeJson.rates.EUR
                self.thb = objectLikeJson.rates.THB
                self.gbp = objectLikeJson.rates.GBP
                self.chf = objectLikeJson.rates.CHF
                self.jpy = objectLikeJson.rates.JPY
                DispatchQueue.main.async {
                    self.date.text = "Курс за \(objectLikeJson.date)"
                }

            } catch {
                print(error)
            }
        }.resume()


        rubTF.addTarget(self, action: #selector(rubTF_hasChanged(textField:)), for: .editingChanged)
        usdTF.addTarget(self, action: #selector(usdTF_hasChanged(textField:)), for: .editingChanged)
        eurTF.addTarget(self, action: #selector(eurTF_hasChanged(textField:)), for: .editingChanged)
        thbTF.addTarget(self, action: #selector(thbTF_hasChanged(textField:)), for: .editingChanged)
        gbpTF.addTarget(self, action: #selector(gbpTF_hasChanged(textField:)), for: .editingChanged)
        chfTF.addTarget(self, action: #selector(chfTF_hasChanged(textField:)), for: .editingChanged)
        jpyTF.addTarget(self, action: #selector(jpyTF_hasChanged(textField:)), for: .editingChanged)
    }

    @objc func rubTF_hasChanged(textField: UITextField){
        rubTF.text = rubTF.text!.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(rubTF.text!) {} else {
            rubTF.text = String(rubTF.text!.dropLast())
        }
        if rubTF.text!.count < 14 {} else {
            rubTF.text = String(rubTF.text!.dropLast())
        }
        let currency_index = 0
        for i in 0..<7 {
            if i == currency_index { continue }
            currenciesTF[i].text = currenciesTF[currency_index].text! != "" ?
                String((Double(rubTF.text!)!/rub * currencies[i] * 10000).rounded()/10000) : ""
        }
    }

    @objc func usdTF_hasChanged(textField: UITextField){
        usdTF.text = usdTF.text!.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(usdTF.text!){}else {
            usdTF.text = String(usdTF.text!.dropLast())
        }
        if usdTF.text!.count < 14 {} else {
            usdTF.text = String(usdTF.text!.dropLast())
        }
        let currency_index = 1
        for i in 0..<7 {
            if i == currency_index { continue }
            currenciesTF[i].text = currenciesTF[currency_index].text! != "" ?
                String((Double(usdTF.text!)!/usd * currencies[i] * 10000).rounded()/10000) : ""
        }
    }

    @objc func eurTF_hasChanged(textField: UITextField){
        eurTF.text = eurTF.text!.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(eurTF.text!){}else {
            eurTF.text = String(eurTF.text!.dropLast())
        }
        if eurTF.text!.count < 14 {} else {
            eurTF.text = String(eurTF.text!.dropLast())
        }
        let currency_index = 2
        for i in 0..<7 {
            if i == currency_index { continue }
            currenciesTF[i].text = currenciesTF[currency_index].text! != "" ?
                String((Double(eurTF.text!)!/eur * currencies[i] * 10000).rounded()/10000) : ""
        }
    }

    @objc func thbTF_hasChanged(textField: UITextField){
        thbTF.text = thbTF.text!.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(thbTF.text!){}else {
            thbTF.text = String(thbTF.text!.dropLast())
        }
        if thbTF.text!.count < 14 {} else {
            thbTF.text = String(thbTF.text!.dropLast())
        }
        let currency_index = 3
        for i in 0..<7 {
            if i == currency_index { continue }
            currenciesTF[i].text = currenciesTF[currency_index].text! != "" ?
                String((Double(thbTF.text!)!/thb * currencies[i] * 10000).rounded()/10000) : ""
        }
    }

    @objc func gbpTF_hasChanged(textField: UITextField){
        gbpTF.text = gbpTF.text!.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(gbpTF.text!){}else {
            gbpTF.text = String(gbpTF.text!.dropLast())
        }
        if gbpTF.text!.count < 14 {} else {
            gbpTF.text = String(gbpTF.text!.dropLast())
        }
        let currency_index = 4
        for i in 0..<7 {
            if i == currency_index { continue }
            currenciesTF[i].text = currenciesTF[currency_index].text! != "" ?
                String((Double(gbpTF.text!)!/gbp * currencies[i] * 10000).rounded()/10000) : ""
        }
    }

    @objc func chfTF_hasChanged(textField: UITextField){
        chfTF.text = chfTF.text!.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(chfTF.text!){}else {
            chfTF.text = String(chfTF.text!.dropLast())
        }
        if chfTF.text!.count < 14 {} else {
            chfTF.text = String(chfTF.text!.dropLast())
        }
        let currency_index = 5
        for i in 0..<7 {
            if i == currency_index { continue }
            currenciesTF[i].text = currenciesTF[currency_index].text! != "" ?
                String((Double(chfTF.text!)!/chf * currencies[i] * 10000).rounded()/10000) : ""
        }
    }

    @objc func jpyTF_hasChanged(textField: UITextField){
        jpyTF.text = jpyTF.text!.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(jpyTF.text!){}else {
            jpyTF.text = String(jpyTF.text!.dropLast())
        }
        if jpyTF.text!.count < 14 {} else {
            jpyTF.text = String(jpyTF.text!.dropLast())
        }
        let currency_index = 6
        for i in 0..<7 {
            if i == currency_index { continue }
            currenciesTF[i].text = currenciesTF[currency_index].text! != "" ?
                String((Double(jpyTF.text!)!/jpy * currencies[i] * 10000).rounded()/10000) : ""
        }
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

