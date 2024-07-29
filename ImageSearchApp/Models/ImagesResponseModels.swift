//
//  ImagesResponseModels.swift
//  ImageSearchApp
//
//  Created by Алла alla2104 on 25.07.24.
//

import Foundation

struct WelcomeResponse: Codable {
    let results: [ResultImage] }


struct ResultImage: Codable {
    let id: String
    let description: String?
    let urls: ImageUrls
}

struct ImageUrls: Codable {
    let thumb: String
}
