//
//  ImageManager.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit

protocol ImagesDataReceivedDelegate {
    func updateUI(image: Image)
    func handleRequestDataError()
}

struct ImageManager {
    
    var baseUrl = "https://images-api.nasa.gov/search?q="
    var delegate: ImagesDataReceivedDelegate?
    
    func fetchImagesMetaData(userInput: String, page: Int) {
        guard let url = URL(string: createCompoundUrlString(userInput: userInput, currentPage: page)) else {return}
    }
    
    private func createCompoundUrlString(userInput: String, currentPage: Int) -> String {
        return "\(baseUrl)\(userInput)&media_type=image&page=\(currentPage)"
    }
}
