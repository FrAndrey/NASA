//
//  ImageManager.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit

protocol ImagesDataReceivedDelegate {
    func updateUI(image: Image)
    func handleRequestError()
}

struct ImageManager {
    
    var baseUrl = "https://images-api.nasa.gov/search?q="
    var delegate: ImagesDataReceivedDelegate?
    
    func fetchImagesMetaData(userInput: String, page: Int) {
        guard let url = URL(string: createCompoundUrlString(userInput: userInput, currentPage: page)) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if error != nil {
                delegate?.handleRequestError()
                return
            }

            guard let safeData = data else { return }
            
            let results = try? JSONDecoder().decode(ImageCollection.self, from: safeData)
            if let capturedResults = results {
                for item in capturedResults.collection.items {
                    for imageMetaData in item.data {
                        for link in item.links {
                            let hyperlink = link.href
                            let title = imageMetaData.title
                            let description = imageMetaData.description
                            
                            let image = Image(hyperlink: hyperlink, description: description, title: title)
                            self.delegate?.updateUI(image: image)
                        }
                    }
                }
            }
            else {
                delegate?.handleRequestError()
            }
        }
        .resume()
    }
    
    private func createCompoundUrlString(userInput: String, currentPage: Int) -> String {
        return "\(baseUrl)\(userInput)&media_type=image&page=\(currentPage)"
    }
}
