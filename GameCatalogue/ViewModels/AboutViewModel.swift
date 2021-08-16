//
//  AboutViewModel.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 15/08/21.
//

import Foundation

class AboutViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var city = ""

    func fetchProfile() {
        ProfileModel.synchronize()
        DispatchQueue.main.async {
            self.name = ProfileModel.name
            self.email = ProfileModel.email
            self.city = ProfileModel.city
        }
    }
}
