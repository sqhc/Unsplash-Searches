//
//  PhotoSearchViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/25/23.
//

import Foundation

protocol PhotoSearchVMDelegate: AnyObject{
    func getQuery()-> String
    func getPage()-> String
    func getPerPage()-> String
    func getOrder()-> String
}

class PhotoSearchViewModel: NSObject, PhotoSearchVMDelegate{
    var query = ""
    var page = ""
    var perPage = ""
    var order = ""
    
    override init() {
        super.init()
    }
    
    func getQuery() -> String {
        return self.query
    }
    
    func getPage() -> String {
        return self.page
    }
    
    func getPerPage() -> String {
        return self.perPage
    }
    
    func getOrder() -> String {
        return self.order
    }
}
