//
//  PhotoSearchViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/25/23.
//

import Foundation

class PhotoSearchViewModel: NSObject{
    var query = ""
    var page = ""
    var perPage = ""
    var order = ""
    
    override init() {
        super.init()
    }
}
