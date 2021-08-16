//
//  AboutView.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import SwiftUI

struct AboutView: View {
    @ObservedObject var viewModel = AboutViewModel()

    var body: some View {
        ZStack {
            VStack {
                Image("pp")
                    .resizable()
                    .frame(width: 250, height: 250,
                           alignment: Alignment/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text(viewModel.name)
                    .font(.title)
                Text(viewModel.email)
                    .font(.subheadline).foregroundColor(.grayText).padding(.bottom, 10)
                Text(viewModel.city)
                    .font(.headline)
            }.padding(.bottom, 20)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: EditProfileView().navigationBarTitle(Text("Edit Profile"))) {
                        ZStack {
                            Capsule()
                                .fill(Color.main).frame(width: 75, height: 75).padding()
                            Image(systemName: "pencil")
                                .resizable().frame(width: 30, height: 30).foregroundColor(.white)
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.fetchProfile()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
