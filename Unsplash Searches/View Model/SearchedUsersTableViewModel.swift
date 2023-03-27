//
//  SearchedUsersTableViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import Foundation
import Dispatch

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
    
    func getUsers(complete: @escaping (_ errorMessage: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async {
            APIManager().decodeRequest(url: searchUsersLink, option: .user, complete: {
                [weak self] success, users, errorMessage in
                if success{
                    let users = users as! SearchedUsers
                    self?.fetchUser(users: users.results)
                }
                else{
                    complete(errorMessage!)
                }
            })
        }
    }
    
    var reloadTableView: (()->Void)?
    
    var cellViewModels = [SearchedUserCellModel](){
        didSet{
            reloadTableView?()
        }
    }
    
    func fetchUser(users: [SearchedUser]){
        var vms = [SearchedUserCellModel]()
        for user in users {
            vms.append(createViewModel(profileImageLink: user.profile_image.medium!, userName: user.username!, realName: user.name!, id: user.id!, updateDate: user.updated_at!, userPhotos: user.photos))
        }
        cellViewModels = vms
    }
    
    func createViewModel(profileImageLink: String, userName: String, realName: String, id: String, updateDate: String, userPhotos: [UserPhoto])-> SearchedUserCellModel{
        return SearchedUserCellModel(profileImageLink: profileImageLink, userName: userName, realName: realName, id: id, updatedDate: updateDate, userPhotos: userPhotos)
    }
    
    func getViewModel(indexPath: IndexPath)-> SearchedUserCellModel{
        return cellViewModels[indexPath.row]
    }
}
