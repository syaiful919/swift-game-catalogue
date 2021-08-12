//
//  GameCard.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct GameCard :View{
    let data: GameModel
    
    
    var body : some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white).shadow(radius: 3)
            VStack{
                WebImage(url: URL(string: data.image)!)
                    .resizable().scaledToFill()
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 200,
                           maxHeight: 200,
                           alignment: .topLeading)
                    .clipped()
                
                
                VStack(alignment: .leading){
                    Text(data.name)
                        .font(.system(size: 24)).bold().foregroundColor(.blackText).lineLimit(2)
                    Text(DateHelper.format(date:data.released))
                        .font(.subheadline).foregroundColor(.grayText).padding(.bottom,5)
                    HStack{
                        RatingStar(rate: data.rating, size:20)
                        Spacer()
                    }
                    
                    NavigationLink(
                        destination:DetailView(gameId: data.id).navigationBarTitle(Text("Game Detail"))) {
                        Text("see details")
                            .font(.callout).bold().foregroundColor(.main).padding(.top, 5).frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    
                }.padding(10)
                
            }.cornerRadius(10)
        }
        .padding(5)
    }
}

