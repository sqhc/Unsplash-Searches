//
//  SearchedPhotoDataModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation

struct SearchedPhotos: Codable{
    let total_pages: Int?
    let results: [SearchedPhoto]
}

struct SearchedPhoto: Codable{
    let id: String?
    let urls: SearchedPhotoLink
}

struct SearchedPhotoLink: Codable{
    let regular: String?
}
