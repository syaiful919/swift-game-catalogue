//
//  Game.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import Foundation
import SwiftUI

struct GameModel: Identifiable {
    var id: Int32
    var name: String = ""
    var description: String = ""
    var image: String
    var released: String = ""
    var rating: Int32
    var metacritic: Int32 = -1
    var playtime: Int32
    var platforms: String = ""
    var genres: String = ""
    var ageRating: String = "Not rated"
}
