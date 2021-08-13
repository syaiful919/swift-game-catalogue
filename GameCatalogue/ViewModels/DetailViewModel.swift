//
//  DetailViewModel.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 12/08/21.
//

import Foundation
import Combine
import SwiftyJSON

class DetailViewModel: ObservableObject {
    @Published var game: GameModel?
    @Published var gameDataStatus: DataStatus = DataStatus.initial

    func fetchGame(id: Int) {
        gameDataStatus = DataStatus.loading
        guard let url = URL(string: "\(Constants.baseUrl)/games/\(id)?key=\(Constants.apiKey)") else {return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    let game = GameModel(
                        id: json["id"].intValue,
                        name: json["name"].stringValue,
                        description: json["description_raw"].stringValue,
                        image: json["background_image"].stringValue,
                        released: json["released"].stringValue,
                        rating: json["rating"].intValue,
                        ratingCount: json["ratings_count"].intValue,
                        metacritic: json["metacritic"].intValue,
                        playtime: json["playtime"].intValue,
                        platforms: json["platforms"].arrayValue.map {$0["platform"]["name"].stringValue},
                        genres: json["genres"].arrayValue.map {$0["name"].stringValue},
                        tags: json["tags"].arrayValue.map {$0["name"].stringValue},
                        screenshots: json["short_screenshots"].arrayValue.map {$0["name"].stringValue},
                        ageRating: json["esrb_rating"]["name"].stringValue
                    )
                    DispatchQueue.main.async {
                        self.game = game
                        self.gameDataStatus = DataStatus.loaded
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.gameDataStatus = DataStatus.failed
                    }
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
                DispatchQueue.main.async {
                    self.gameDataStatus = DataStatus.failed
                }
            }
        }
        task.resume()
    }
}
