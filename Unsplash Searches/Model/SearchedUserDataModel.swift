//
//  SearchedUserDataModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation

struct SearchedUsers: Codable{
    let total_pages: Int?
    let results: [SearchedUser]
}

struct SearchedUser: Codable{
    let id: String?
    let updated_at: String?
    let username: String?
    let name: String?
    let profile_image: UserProfileImage
    let photos: [UserPhoto]
}

struct UserProfileImage: Codable{
    let medium: String?
}

struct UserPhoto: Codable{
    let urls: UserPhotoLink
}

struct UserPhotoLink: Codable{
    let regular: String?
}
