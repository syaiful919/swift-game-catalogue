//
//  SearchViewModel.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 15/08/21.
//

import Foundation
import Combine
import SwiftyJSON

class SearchViewModel: ObservableObject {
    @Published var games = [GameModel]()
    @Published var gamesDataStatus: DataStatus = DataStatus.initial
    var debounceTimer: Timer?

    func searchAction(input: String) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.games.removeAll()
            if !input.isEmpty {
                self.fetchGames(input: input)
            }
        }
    }

    func fetchGames(input: String) {
        DispatchQueue.main.async {
            self.gamesDataStatus = DataStatus.loading
        }
        guard let url = URL(string: "\(Constants.baseUrl)/games?search=\(input)&key=\(Constants.apiKey)") else {return}
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    let items = json["results"].array!

                    for item in items {
                        let platformList = item["platforms"].arrayValue.map {$0["platform"]["name"].stringValue}
                        let genreList = item["genres"].arrayValue.map {$0["name"].stringValue}

                        let game = GameModel(
                            id: item["id"].int32Value,
                            name: item["name"].stringValue,
                            image: item["background_image"].stringValue,
                            released: item["released"].stringValue,
                            rating: item["rating"].int32Value,
                            metacritic: item["metacritic"].int32Value,
                            playtime: item["playtime"].int32Value,
                            platforms: platformList.joined(separator: ", "),
                            genres: genreList.joined(separator: ", "),
                            ageRating: item["esrb_rating"].stringValue
                        )
                        DispatchQueue.main.async {
                            self.games.append(game)
                        }
                    }
                    DispatchQueue.main.async {
                        self.gamesDataStatus = self.games.isEmpty ? DataStatus.empty : DataStatus.loaded
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.gamesDataStatus = DataStatus.failed
                    }
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
                DispatchQueue.main.async {
                    self.gamesDataStatus = DataStatus.failed
                }
            }
        }
        task.resume()
    }
}
