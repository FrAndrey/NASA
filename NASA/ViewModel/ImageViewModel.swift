//
//  ImageViewModel.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import Foundation

struct ImageViewModel {
    
    let title: String
    let description: String
    let hyperlink: String
    
    init (image: Image){
        self.title = image.title
        self.description = image.description
        self.hyperlink = image.hyperlink
    }
}
