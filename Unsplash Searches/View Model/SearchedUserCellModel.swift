//
//  SearchedUserCellModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation

protocol SearchedUserCellModelDelegate{
    func getUserName()-> String
    func getPhotos()-> [UserPhoto]
}

struct SearchedUserCellModel: SearchedUserCellModelDelegate{
    let profileImageLink: String?
    let userName: String?
    let realName: String?
    let id: String?
    let updatedDate: String?
    let userPhotos: [UserPhoto]
    
    func getUserName() -> String {
        return userName!
    }
    
    func getPhotos() -> [UserPhoto] {
        return userPhotos
    }
}
