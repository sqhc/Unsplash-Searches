//
//  CollectionSearchViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/23/23.
//

import Foundation

protocol CollectionDelegate: AnyObject{
    func sendQuery()-> String
    func sendPage()-> String
    func sendPerPage()-> String
}

class CollectionSearchViewModel: NSObject, CollectionDelegate{
    var query = ""
    var page = ""
    var perPage = ""
    
    override init(){
        super.init()
    }
    
    func sendQuery() -> String {
        return self.query
    }
    
    func sendPage() -> String {
        return self.page
    }
    
    func sendPerPage() -> String {
        return self.perPage
    }
}
