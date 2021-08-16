//
//  SearchView.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 14/08/21.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State private var searchText = ""

    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "magnifyingglass")
                FirstResponderTextField(text: $searchText, placeholder: "Search...")
                    .onChange(of: searchText) { value in
                        viewModel.searchAction(input: value)
                    }.padding(.horizontal, 10).padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.background))
                    .foregroundColor(.blackText)
            }.padding(.horizontal, 20).padding(.top, 25)
            if viewModel.gamesDataStatus == DataStatus.loaded {
                VStack(alignment: .leading) {
                    ForEach(viewModel.games) { game in
                        SearchItem(data: game)
                    }.padding(.horizontal)
                }.padding(.vertical)
            } else if viewModel.gamesDataStatus == DataStatus.failed {
                Text("Something Error")
                    .foregroundColor(.blackText).padding()
            } else if viewModel.gamesDataStatus == DataStatus.empty {
                Text("Game not found")
                    .foregroundColor(.blackText).padding()
            } else if viewModel.gamesDataStatus == DataStatus.loading {
                Loading().padding()
            }
        }
    }
}

struct SearchItem: View {
    let data: GameModel

    var body : some View {
        NavigationLink(
            destination: DetailView(gameId: Int(data.id)).navigationBarTitle(Text("Game Detail"))) {
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.headline).bold().foregroundColor(.blackText).lineLimit(2)
                Text(data.platforms)
                    .font(.subheadline).foregroundColor(.grayText).lineLimit(1).padding(.bottom)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
