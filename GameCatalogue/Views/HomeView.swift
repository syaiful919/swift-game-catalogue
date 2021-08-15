//
//  HomeView.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.gamesDataStatus == DataStatus.loaded {
                    ScrollView {
                        ForEach(viewModel.games) { game in
                            GameCard(data: game)
                                .padding(.bottom, game.id == viewModel.games.last?.id ? 100 : 0)
                        }.padding()
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
                } else {
                    Loading()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: FavoriteView().navigationBarTitle(Text("Favorites"))) {
                            ZStack {
                                Capsule()
                                    .fill(Color.red).frame(width: 75, height: 75).padding()
                                Image(systemName: "heart.fill")
                                    .resizable().frame(width: 35, height: 35).foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Explore The Best Games", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    NavigationLink(
                        destination: AboutView().navigationBarTitle(Text("About"))) {
                        Image(systemName: "info.circle.fill")
                    })
        }
        .accentColor(.main)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
