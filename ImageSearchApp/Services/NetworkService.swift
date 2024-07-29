//
//  NetworkService.swift
//  ImageSearchApp
//
//  Created by Алла alla2104 on 25.07.24.
//

import Foundation

final class NetworkService {
    
    private let hostForSearch = "https://api.unsplash.com/search/photos"
    private let hostForRandomImages = "https://api.unsplash.com/photos/random"
    private let apiKey = "YourAPIKeyHere"
    
    
    func loadRandomImages(count: Int = 15,
                          completion: @escaping ([ImageModel]) -> Void) {
        guard var components = URLComponents(string: hostForRandomImages)
        else { return }
        components.queryItems = [
            URLQueryItem(name: "count", value: "\(count)"),
            URLQueryItem(name: "client_id", value: apiKey)
        ]
        
        guard let url = components.url 
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data 
            else { return }
            
            do {
                let responseModels = try JSONDecoder().decode([ResultImage].self, 
                                                              from: jsonData)
                let images = responseModels.map { image in
                    ImageModel(id: image.id, 
                               url: image.urls.thumb,
                               description: image.description ?? "No description")
                }
                DispatchQueue.main.async {
                    completion(images)
                }
            } catch {
                print("Decoding error  JSON: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
    
    func searchImages(query: String,
                      completion: @escaping ([ImageModel]) -> Void) {
        
        guard var components = URLComponents(string: hostForSearch)
        else { return }
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "client_id", value: apiKey)
        ]
        
        guard let url = components.url
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data
            else { return }
            
            do {
                let responseModel = try JSONDecoder().decode(WelcomeResponse.self,
                                                             from: jsonData)
                let images = responseModel.results.map { image in
                    ImageModel(id: image.id,
                               url: image.urls.thumb,
                               description: image.description ?? "No description")
                }
                DispatchQueue.main.async {
                    completion(images)
                }
            } catch {
                print("Decoding error  JSON: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}
