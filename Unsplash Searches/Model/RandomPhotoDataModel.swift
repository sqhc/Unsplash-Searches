//
//  RandomPhotoDataModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/25/23.
//

import Foundation

struct RandomPhoto: Codable{
    let urls: RandomPhotoLink
}

struct RandomPhotoLink: Codable{
    let full: String?
}
