//
//  SearchedPhotosCollectionViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation
import Dispatch

class SearchedPhotosCollectionViewModel: NSObject{
    weak var delegate: PhotoSearchVMDelegate!
    var current_page = 1
    override init() {
        super.init()
    }
    
    func formAPI(){
        searchPhotosLink += "&query=\(delegate.getQuery())"
        let page = delegate.getPage()
        let perPage = delegate.getPerPage()
        let order = delegate.getOrder()
        if perPage != ""{
            searchPhotosLink += "&per_page=\(perPage)"
        }
        if order != ""{
            searchPhotosLink += "&order_by=\(order)"
        }
        if page != ""{
            searchPhotosLink += "&page=\(page)"
            current_page = Int(page) ?? 1
        }
    }
    
    func getPhotos(complete: @escaping (_ errorMessage: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async {
            APIManager().decodeRequest(url: searchPhotosLink, option: .photo, complete: {
                [weak self] success, photos, error in
                if success{
                    let photos = photos as! SearchedPhotos
                    self?.fetchPhoto(photos: photos.results)
                }
                else{
                    complete(error!)
                }
            })
        }
    }
    
    var reloadCollectionView: (()->Void)?
    
    var photosCellModels = [SearchedPhotoCellModel](){
        didSet{
            reloadCollectionView?()
        }
    }
    
    func fetchPhoto(photos: [SearchedPhoto]){
        var vms = [SearchedPhotoCellModel]()
        for photo in photos {
            let id = photo.id ?? "Unknown"
            let link = photo.urls.regular!
            vms.append(createCellModel(id: id, link: link))
        }
        photosCellModels = vms
    }
    
    func createCellModel(id: String, link: String)->SearchedPhotoCellModel{
        return SearchedPhotoCellModel(id: id, photo_url: link)
    }
    
    func getCellModel(indexPath: IndexPath)-> SearchedPhotoCellModel{
        return photosCellModels[indexPath.row]
    }
}
