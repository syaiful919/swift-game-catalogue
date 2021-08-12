//
//  Game.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import Foundation
import SwiftUI


struct GameModel: Identifiable {
    var id : Int
    var name : String
    var description : String?
    var image : String
    var released : String
    var rating : Int
    var ratingCount : Int
    var metacritic: Int?
    var playtime: Int
    var platforms: [String]
    var genres: [String]
    var tags: [String]
    var screenshots: [String]
    var ageRating: String?
    
}
