//
//  CoinData.swift
//  ByteCoin
//
//  Created by Bektemur on 10/02/23.
//

import Foundation

struct CoinData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
