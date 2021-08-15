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
    @Published var isFav: Bool = false

    private lazy var gameProvider: GameProvider = { return GameProvider() }()

    func toogleFav() {
        if isFav {
            gameProvider.deleteGame(Int(game!.id)) {
                DispatchQueue.main.async {
                    self.isFav = !self.isFav
                }
            }
        } else {
            gameProvider.createGame(game!) {
                DispatchQueue.main.async {
                    self.isFav = !self.isFav
                }
            }
        }
    }

    func fetchGame(id: Int) {
        gameProvider.getGame(id) { data in
            if let data = data {
                DispatchQueue.main.async {
                    self.game = data
                    self.isFav = !self.isFav
                    self.gameDataStatus = DataStatus.loaded
                }
            } else {
                self.fetchGameFromNetwork(id: id)
            }
        }

    }

    func fetchGameFromNetwork(id: Int) {
        DispatchQueue.main.async {
            self.gameDataStatus = DataStatus.loading
        }

        guard let url = URL(string: "\(Constants.baseUrl)/games/\(id)?key=\(Constants.apiKey)") else {return}
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    let platformList = json["platforms"].arrayValue.map {$0["platform"]["name"].stringValue}
                    let genreList = json["genres"].arrayValue.map {$0["name"].stringValue}

                    let game = GameModel(
                        id: json["id"].int32Value,
                        name: json["name"].stringValue,
                        description: json["description_raw"].stringValue,
                        image: json["background_image"].stringValue,
                        released: json["released"].stringValue,
                        rating: json["rating"].int32Value,
                        metacritic: json["metacritic"].int32Value,
                        playtime: json["playtime"].int32Value,
                        platforms: platformList.joined(separator: ", "),
                        genres: genreList.joined(separator: ", "),
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
