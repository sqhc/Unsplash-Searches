//
//  CollectionPhotosCollectionViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/28/23.
//

import Foundation
import Dispatch

class CollectionPhotosCollectionViewModel: NSObject{
    
    var delegate: CollectionsCellViewModelDelegate!
    
    override init() {
        super.init()
    }
    
    func getPhotos(complete: @escaping (_ errorMessage: String)->()){
        let url = delegate.getLink() + client_id
        DispatchQueue.global(qos: .background).async {
            APIManager().decodeRequest(url: url, option: .collectionPhoto, complete: {
                [weak self] success, photos, error in
                if success{
                    let photos = photos as! [SearchedPhoto]
                    self?.fetchPhoto(photos: photos)
                }
                else{
                    complete(error!)
                }
            })
        }
    }
    
    var reloadCollectionView: (()->Void)?
    
    var cellModels = [CollectionPhotoCellModel](){
        didSet{
            reloadCollectionView?()
        }
    }
    
    func fetchPhoto(photos: [SearchedPhoto]){
        var vms = [CollectionPhotoCellModel]()
        for photo in photos {
            vms.append(createCellModel(link: photo.urls.regular!))
        }
        cellModels = vms
    }
    
    func createCellModel(link: String?)-> CollectionPhotoCellModel{
        return CollectionPhotoCellModel(photoLink: link)
    }
    
    func getCellModel(indexPath: IndexPath)-> CollectionPhotoCellModel{
        return cellModels[indexPath.row]
    }
}
