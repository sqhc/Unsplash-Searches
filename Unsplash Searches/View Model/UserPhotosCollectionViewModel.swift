//
//  UserPhotosCollectionViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/27/23.
//

import Foundation
import Dispatch

class UserPhotosCollectionViewModel: NSObject{
    
    var delegate: SearchedUserCellModelDelegate!
    
    override init() {
        super.init()
    }
    
    func getPhotos(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            let photos = self?.delegate.getPhotos()
            self?.fetchPhoto(photos: photos!)
        }
    }
    
    var reloadCollectionView: (()->Void)?
    
    var cellViewModels = [UserPhotoCellViewModel](){
        didSet{
            reloadCollectionView?()
        }
    }
    
    func fetchPhoto(photos: [UserPhoto]){
        var vms = [UserPhotoCellViewModel]()
        for photo in photos {
            vms.append(createCellModel(photoLink: photo.urls.regular))
        }
        cellViewModels = vms
    }
    
    func createCellModel(photoLink: String?)-> UserPhotoCellViewModel{
        return UserPhotoCellViewModel(userPhotoLink: photoLink)
    }
    
    func getCellModel(indexPath: IndexPath)-> UserPhotoCellViewModel{
        return cellViewModels[indexPath.row]
    }
}
