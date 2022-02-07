//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
  
protocol byteCoinManagerDelegate {
    func didFailWithError (error: Error)
    func didUpdatePrice(price: Double, currency : String)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "9CC1149C-9D71-4B49-9EFA-6E8833A984AE"
    var currencyType = ""
    let currencyArray = ["EUR","USD","TRY"]
    
    var delegate : byteCoinManagerDelegate?
    
    mutating func getCoinPrice(for currency : String)   {
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        self.currencyType = currency
        performRequest(with: urlString)
    }
    
    func performRequest(with UrlString : String) {
        if let url = URL(string: UrlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if  error != nil  {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let byteCoinData = data {
                    if let  byteCoinPrice = self.parseJson(byteCoinData){
                        self.delegate?.didUpdatePrice(price: byteCoinPrice,currency: currencyType)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) -> Double? {
            let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
        
    }
    
    
}
   

