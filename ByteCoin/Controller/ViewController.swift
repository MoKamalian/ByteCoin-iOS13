//
//
//
//
//
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data for picker is being provided by this class
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
        
    }

   
    
}


//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // This is the number of columns
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // This is the number of currencies we want to display
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // When the user selects something, do this
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency)
        currencyLabel.text = coinManager.currencyArray[row]
    }
}






//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func updatedPrice(exchangeRate: CurrencyData) {
        
        DispatchQueue.main.async {
            self.bitCoinLabel.text = String(exchangeRate.rate)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}



