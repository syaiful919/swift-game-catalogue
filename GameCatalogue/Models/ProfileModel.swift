//
//  ProfileModel.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 16/08/21.
//

import Foundation

struct ProfileModel {
    static let nameKey = "name"
    static let emailKey = "email"
    static let cityKey = "city"

    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? "Syaiful Izzuddin Salam"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }

    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? "syaiful919@gmail.com"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }

    static var city: String {
        get {
            return UserDefaults.standard.string(forKey: cityKey) ?? "Jakarta Barat"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: cityKey)
        }
    }

    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
