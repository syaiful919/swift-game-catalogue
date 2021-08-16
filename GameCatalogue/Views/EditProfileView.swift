//
//  EditProfileView.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 15/08/21.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel = EditProfileViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var city = ""

    @State private var showingAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Name").bold().padding(.bottom, 5)
            TextField("input your name", text: $name)
                .padding(.horizontal, 10).padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.background))
                .foregroundColor(.blackText).padding(.bottom, 10)
            Text("Email").bold().padding(.bottom, 5)
            TextField("input your email", text: $email)
                .padding(.horizontal, 10).padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.background))
                .foregroundColor(.blackText).padding(.bottom, 10)
            Text("City").bold().padding(.bottom, 5)
            TextField("input your city", text: $city)
                .padding(.horizontal, 10).padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.background))
                .foregroundColor(.blackText).padding(.bottom, 10)
            Spacer()
            Button("Save") {
                if name.isEmpty || email.isEmpty || city.isEmpty {
                    showingAlert = true
                } else {
                    viewModel.saveProfil(name, email, city)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.buttonStyle(RoundedRectangleButtonStyle())
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Alert"),
                      message: Text("All fields must be filled"),
                      dismissButton: .default(Text("OK"))
                )
            }
        }.padding().onAppear {
            ProfileModel.synchronize()
            self.name = ProfileModel.name
            self.email = ProfileModel.email
            self.city = ProfileModel.city
        }
    }
}

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.white)
      Spacer()
    }
    .padding()
    .background(Color.main.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
