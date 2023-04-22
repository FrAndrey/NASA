//
//  Image.swift
//  NASA
//
//  Created by Administrator on 2023-04-21.
//

import UIKit

struct Image {
    let hyperlink: String
    let description: String
    let title: String
}

// JSON decoding
struct ImageCollection: Codable {
    let collection: Collection
}

struct Collection: Codable {
    let items: [Item]
}

struct Item: Codable {
    let href: String
    let data: [Datum]
    let links: [ItemLink]
}

struct Datum: Codable {
    let description, title: String
    }

struct ItemLink: Codable {
    let href: String
}
