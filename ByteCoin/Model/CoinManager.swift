//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func updatedPrice(exchangeRate: CurrencyData)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "77CFCAD9-3EB2-4EB5-B2F0-08FE50AC516C"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let finalURL = "\(baseURL)\(currency)?apikey=\(apiKey)"
        HTTPrequest(with: finalURL)
        
    }
    
    // Method conducts HTTP request
    func HTTPrequest(with urlString: String) {
        if let url = URL(string: urlString) {
        let urlSession = URLSession(configuration: .default)
            let sessionTask = urlSession.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                } else {
                    // print(String(data: data!, encoding: String.Encoding.utf8)!)
                    if let nonErrorData = data {
                        let exchangePrice = self.JSONparser(nonErrorData)
                        self.delegate?.updatedPrice(exchangeRate: exchangePrice!)
                    }
                }
            } 
            sessionTask.resume()
        }
    }
  
    // Decode the JSON response
    func JSONparser(_ data: Data)->CurrencyData? {
        let jsonDecoder = JSONDecoder()
        do {
            let finalData = try jsonDecoder.decode(CurrencyData.self, from: data)
            return finalData
            
        } catch {
            print(error)
            return nil
        }
    }
    
    
}
