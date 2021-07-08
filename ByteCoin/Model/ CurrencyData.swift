//
//
//

import Foundation

// THE NAMES OF THE STRUC HERE MUST MATCH THE NAMES IN THE JSON RESPONSE
struct CurrencyData: Decodable {
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Float
}







