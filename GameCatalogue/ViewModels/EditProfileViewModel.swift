//
//  EditProfileViewModel.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 16/08/21.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    func saveProfil(_ name: String, _ email: String, _ city: String) {
        ProfileModel.name = name
        ProfileModel.email = email
        ProfileModel.city = city
    }
}
