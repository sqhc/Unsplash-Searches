//
//  UsersSearchViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation

protocol UsersSearchVMDelegate: AnyObject{
    func getQuery()->String
    func getPage()->String
    func getPerPage()->String
}

class UsersSearchViewModel: NSObject, UsersSearchVMDelegate{
    var query = ""
    var page = ""
    var perPage = ""
    
    override init() {
        super.init()
    }
    
    func getQuery() -> String {
        return query
    }
    
    func getPage() -> String {
        return page
    }
    
    func getPerPage() -> String {
        return perPage
    }
}
