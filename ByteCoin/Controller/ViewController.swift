//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController //,UIPickerViewDataSource,//UIPickerViewDelegate
{

    @IBOutlet weak var eurButton: UIButton!
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
      
    }

    @IBAction func currencyButtonPressed(_ sender: UIButton) {
      let  selectedButtonText = sender.currentTitle!
    
       eurButton.isSelected = false
       usdButton.isSelected = false
       tryButton.isSelected = false
       sender.isSelected = true
       coinManager.getCoinPrice(for: selectedButtonText)

    }


}
//MARK: -ByteCoin

extension ViewController : byteCoinManagerDelegate {
    
    func didFailWithError(error: Error) {
     
        print(error)
       
    }
    
    func didUpdatePrice(price: Double, currency: String) {
        DispatchQueue.main.async { [self] in
            self.currencyLabel.text = currency
            self.bitcoinLabel.text = String(format: "%.2f", price)
    }
    

    }
    
}


