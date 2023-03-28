//
//  CollectionsCellViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/24/23.
//

import Foundation

protocol CollectionsCellViewModelDelegate{
    func getTitle()-> String
    func getLink()-> String
}

struct CollectionsCellViewModel: CollectionsCellViewModelDelegate{
    var title: String?
    var id: String?
    var description: String?
    var publishTime: String?
    var photoLink: String?
    
    func getTitle() -> String {
        return title!
    }
    
    func getLink() -> String {
        return photoLink!
    }
}
