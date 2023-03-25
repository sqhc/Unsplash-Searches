//
//  CollectionsTableViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/24/23.
//

import Foundation

class CollectionsTableViewModel: NSObject{
    var currentPage = 0
    weak var delegate: CollectionDelegate!
    override init() {
        super.init()
    }
    
    func formAPI(){
        searchCollectionsLink += "&\(delegate.sendQuery())"
        let perpage = delegate.sendPerPage()
        let page = delegate.sendPage()
        if perpage != ""{
            searchCollectionsLink += "&\(perpage)"
        }
        if page != ""{
            searchCollectionsLink += "&\(page)"
        }
    }
    
    func getCollections(complete: @escaping (_ errorMessage: String)->()){
        APIManager().decodeRequest(url: searchCollectionsLink, option: .collection, complete: {
            [weak self] success, collection, message in
            if success{
                let collections = collection as! Collections
                self?.fetchCollection(collections: collections.results)
            }
            else{
                complete(message!)
            }
        })
    }
    
    var reloadTableView: (()->Void)?
    
    var collectionsCellModels = [CollectionsCellViewModel](){
        didSet{
            reloadTableView?()
        }
    }
    
    func fetchCollection(collections: [Collection]){
        var vms = [CollectionsCellViewModel]()
        for collection in collections {
            vms.append(createCellModel(title: collection.title!, id: collection.id!, description: collection.description!, publish: collection.published_at!, link: (collection.links?.photos!)!))
        }
    }
    
    func createCellModel(title: String, id: String, description: String, publish: String, link: String)-> CollectionsCellViewModel{
        return CollectionsCellViewModel(title: title, id: id, description: description, publishTime: publish, photoLink: link)
    }
    
    func getCellModel(indexPath: IndexPath)-> CollectionsCellViewModel{
        return collectionsCellModels[indexPath.row]
    }
}
