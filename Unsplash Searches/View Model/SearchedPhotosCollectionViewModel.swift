//
//  SearchedPhotosCollectionViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation

class SearchedPhotosCollectionViewModel: NSObject{
    override init() {
        super.init()
    }
    
    weak var delegate: PhotoSearchVMDelegate!
}
