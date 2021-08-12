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
        NavigationView{
            ZStack{
                if(viewModel.gamesDataStatus == DataStatus.loaded){
                    ScrollView{
                        ForEach(viewModel.games){game in
                            GameCard(data: game)
                            
                        }.padding()
                    }
                } else if(viewModel.gamesDataStatus == DataStatus.failed){
                    Text("Something error")
                }
                
                else{
                    Loading()
                }
                
            }
            
            .navigationBarTitle("Explore The Best Games", displayMode: .inline)
            .navigationBarItems(
               
                trailing:
                    NavigationLink(
                        destination:AboutView().navigationBarTitle(Text("About"))) {
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