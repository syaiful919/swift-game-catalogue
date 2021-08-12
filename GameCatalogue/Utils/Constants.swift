//
//  Constants.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import Foundation

struct Constants {
     static let baseUrl = "https://api.rawg.io/api"
     static let apiKey = "b5d5b03dc8f04431a000bc19969b9400"
 }

enum DataStatus {
    case initial, loading, loaded, failed, empty
}
