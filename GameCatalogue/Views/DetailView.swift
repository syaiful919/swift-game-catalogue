//
//  DetailView.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 12/08/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct DetailView: View {
    
    let gameId: Int
    
    @ObservedObject var viewModel = DetailViewModel()
    
    var body: some View {
        ZStack{
            if(viewModel.gameDataStatus == DataStatus.loaded){
                ScrollView{
                    ZStack(alignment: .bottom){
                        let width = UIScreen.main.bounds.size.width
                        Rectangle()
                            .fill(Color.white).frame(width: width, height: 250)
                        WebImage(url: URL(string: viewModel.game!.image)!)
                            .resizable().scaledToFill().frame(width: width, height: 250.0).clipped()
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color.white).frame(width: width, height: 100).offset(y:75)
                    }
                    VStack(alignment:.leading){
                        Text(viewModel.game!.name).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().foregroundColor(.blackText)
                        Text(DateHelper.format(date:viewModel.game!.released))
                            .font(.subheadline).foregroundColor(.grayText)
                        RatingStar(rate: viewModel.game!.rating, size:25).padding(.bottom,20)
                        
                        HStack{
                            DescriptionBox(title: "Playtime", value: "\(viewModel.game!.playtime) hours")
                            DescriptionBox(title: "Metascore", value: viewModel.game!.metacritic != nil ? "\(viewModel.game!.metacritic!)" : "Not scored")
                            DescriptionBox(title: "Age Rating", value: "\(viewModel.game!.ageRating ?? "Not rated")")
                            
                        }.padding(.bottom,20)
                        
                        DescriptionItem(title: "Genres", value: "\(viewModel.game!.genres.joined(separator: ", "))")
                        DescriptionItem(title: "Platform", value: "\(viewModel.game!.platforms.joined(separator: ", "))")
                        DescriptionItem(title: "Description", value: "\(viewModel.game!.description!)")
                          
                        HStack{
                            Spacer()
                        }
                        
                    }.padding(.horizontal)
                }
            } else if(viewModel.gameDataStatus == DataStatus.failed){
                Text("Something error")
            }
            
            else{
                Loading()
            }
            
        }
        .onAppear{
            viewModel.fetchGame(id: gameId)
        }
        
    }
}

struct DescriptionItem: View {
    let title:String
    let value:String
    
    var body : some View{
        Text(title)
            .bold().foregroundColor(.blackText).padding(.bottom,5)
        Text(value)
            .foregroundColor(.blackText).padding(.bottom,20)
    }
}

struct DescriptionBox: View {
    let title:String
    let value:String
    
    var body : some View{
        VStack{
            Text(title).bold().foregroundColor(.blackText).padding(.bottom,2)
            Text(value).foregroundColor(.grayText)
        }.frame(width: 105, alignment: .center)
        .padding(.vertical, 8)
        .background(Color.background.opacity(0.75))
        .cornerRadius(10).frame(maxWidth: .infinity)
    }
}
