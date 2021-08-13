//
//  AboutView.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Image("pp")
                .resizable()
                .frame(width: 250, height: 250, alignment: Alignment/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("Syaiful Izzuddin Salam")
                .font(.title).padding(.bottom, 5)
            Text("syaiful919@gmail.com")
                .font(.headline)
        }.padding(.bottom, 20)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
