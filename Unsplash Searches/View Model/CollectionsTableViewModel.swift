//
//  CollectionsTableViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/24/23.
//

import Foundation
import Dispatch

class CollectionsTableViewModel: NSObject{
    var currentPage = 1
    weak var delegate: CollectionDelegate!
    override init() {
        super.init()
    }
    
    func formAPI(){
        searchCollectionsLink += "&query=\(delegate.sendQuery())"
        let perpage = delegate.sendPerPage()
        let page = delegate.sendPage()
        if perpage != ""{
            searchCollectionsLink += "&per_page=\(perpage)"
        }
        if page != ""{
            searchCollectionsLink += "&page=\(page)"
            currentPage = Int(page) ?? 1
        }
    }
    
    func getCollections(complete: @escaping (_ errorMessage: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async{
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
            let title = collection.title ?? "Unknown"
            let id = collection.id ?? "Unknown"
            let description = collection.description ?? "Unknown"
            let publish = collection.published_at ?? "Unknown"
            let link = (collection.links?.photos!)!
            vms.append(createCellModel(title: title, id: id, description: description, publish: publish, link: link))
        }
        collectionsCellModels = vms
    }
    
    func createCellModel(title: String, id: String, description: String, publish: String, link: String)-> CollectionsCellViewModel{
        return CollectionsCellViewModel(title: title, id: id, description: description, publishTime: publish, photoLink: link)
    }
    
    func getCellModel(indexPath: IndexPath)-> CollectionsCellViewModel{
        return collectionsCellModels[indexPath.row]
    }
}
