//
//  Indicator.swift
//  ImageSearchApp
//
//  Created by Алла alla2104 on 28.07.24.
//

import SwiftUI

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}
