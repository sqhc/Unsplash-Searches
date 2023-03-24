//
//  CollectionDataModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/23/23.
//

import Foundation

struct Collections: Codable{
    let total_pages: Int?
    let results: [Collection]
}

struct Collection: Codable{
    let id: String?
    let title: String?
    let description: String?
    let published_at: String?
    let links: CollectionLinks?
}

struct CollectionLinks: Codable{
    let photos: String?
}
