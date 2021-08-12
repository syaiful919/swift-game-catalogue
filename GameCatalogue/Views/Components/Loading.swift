//
//  Loading.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 11/08/21.
//

import Foundation
import SwiftUI

struct Loading: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Loading>) -> UIActivityIndicatorView {
        let loading = UIActivityIndicatorView(style: .large)
        loading.color = UIColor.blue
        return loading
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loading>) {
        uiView.startAnimating()
    }
    
}
