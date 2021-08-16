//
//  FavoriteView.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 14/08/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel = FavoriteViewModel()

    var body: some View {
        ZStack {
            if viewModel.gamesDataStatus == DataStatus.loaded {
                ScrollView {
                    Spacer().frame(height: 10)
                    ForEach(viewModel.games) { game in
                        GameCard(data: game)
                            .padding(.bottom, game.id == viewModel.games.last?.id ? 100 : 0)
                    }.padding(.horizontal, 10)
                }
            } else if viewModel.gamesDataStatus == DataStatus.failed {
                VStack {
                    Text("Something Error")
                        .bold().font(.title).foregroundColor(.blackText)
                        .padding(.bottom, 2)
                    Text("please try again later")
                        .font(.subheadline).foregroundColor(.grayText)
                        .padding(.bottom, 30)
                    Button("Reload") {
                        viewModel.fetchGames()
                    }
                }
            } else if viewModel.gamesDataStatus == DataStatus.empty {
                VStack {
                    Text("Your Favorite is Empty")
                        .bold().font(.title).foregroundColor(.blackText)
                        .padding(.bottom, 2)
                    Text("Your favorite games will appear here")
                        .font(.subheadline).foregroundColor(.grayText)
                        .padding(.bottom, 30)
                }
            } else {
                Loading()
            }
        }.onAppear {
            viewModel.fetchGames()
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
