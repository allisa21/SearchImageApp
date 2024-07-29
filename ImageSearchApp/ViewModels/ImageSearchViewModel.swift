//
//  ImageSearchViewModel.swift
//  ImageSearchApp
//
//  Created by Алла alla2104 on 25.07.24.
//

import SwiftUI

final class  ImageSearchViewModel: ObservableObject {
    
    @Published var images: [ImageModel] = []
    @Published var searchText: String = ""
    @Published var expand: Bool = false
    @Published var randomImages: [ImageModel] = []
    
    private var networkService = NetworkService()
    
    init() {
        loadRandomImages()
    }
    
    func loadRandomImages() {
        networkService.loadRandomImages { [weak self] images in
            self?.randomImages = images
        }
    }
    
    func searchImages() {
        networkService.searchImages(query: searchText) { [weak self] images in
            self?.images = images
        }
    }
    
}
