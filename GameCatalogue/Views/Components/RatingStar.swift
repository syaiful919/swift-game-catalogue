//
//  RatingStar.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 12/08/21.
//

import Foundation
import SwiftUI

struct RatingStar: View {
    let rate: Int
    let size: CGFloat

    var body : some View {
        HStack {
            ForEach((1...rate), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: size,
                           height: size,
                           alignment: Alignment/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.yellow)
            }
        }
    }
}
