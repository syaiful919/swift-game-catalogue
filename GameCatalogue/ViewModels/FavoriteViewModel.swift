//
//  FavoriteViewModel.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 15/08/21.
//

import Foundation
import SwiftyJSON

class FavoriteViewModel: ObservableObject {
    @Published var games = [GameModel]()
    @Published var gamesDataStatus: DataStatus = DataStatus.initial

    private lazy var gameProvider: GameProvider = { return GameProvider() }()

    func fetchGames() {
        DispatchQueue.main.async {
            self.gamesDataStatus = DataStatus.loading
        }
        self.gameProvider.getAllGame { result in
            DispatchQueue.main.async {
                if result.isEmpty {
                    self.gamesDataStatus = DataStatus.empty
                } else {
                    self.games = result
                    self.gamesDataStatus = DataStatus.loaded
                }
            }
        }
    }
}
