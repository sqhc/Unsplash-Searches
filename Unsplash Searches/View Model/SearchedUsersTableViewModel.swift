//
//  SearchedUsersTableViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation

class SearchedUsersTableViewModel: NSObject{
    var currentPage = 1
    weak var delegate: UsersSearchVMDelegate!
    
    override init() {
        super.init()
    }
    
    func formAPI(){
        searchUsersLink += "&query=\(delegate.getQuery())"
        let perPage = delegate.getPerPage()
        let page = delegate.getPage()
        if perPage != ""{
            searchUsersLink += "&per_page=\(perPage)"
        }
        if page != ""{
            searchUsersLink += "&page=\(page)"
        }
    }
}
