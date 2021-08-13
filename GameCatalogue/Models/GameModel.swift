//
//  Game.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import Foundation
import SwiftUI

struct GameModel: Identifiable {
    let id: Int
    let name: String
    let description: String?
    let image: String
    let released: String
    let rating: Int
    let ratingCount: Int
    let metacritic: Int?
    let playtime: Int
    let platforms: [String]
    let genres: [String]
    let tags: [String]
    let screenshots: [String]
    let ageRating: String?
}
