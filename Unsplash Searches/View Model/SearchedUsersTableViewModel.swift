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
    var total_page = 0
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
            currentPage = Int(page) ?? 1
        }
        else{
            searchUsersLink += "&page=1"
        }
    }
    
    func getUsers(complete: @escaping (_ errorMessage: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async {
            APIManager().decodeRequest(url: searchUsersLink, option: .user, complete: {
                [weak self] success, users, errorMessage in
                if success{
                    let users = users as! SearchedUsers
                    self?.total_page = users.total_pages!
                    self?.fetchUser(users: users.results)
                    while searchUsersLink.last! != "="{
                        searchUsersLink.removeLast()
                    }
                    searchUsersLink += String((self?.currentPage)! + 1)
                    self?.setCacheValue(page: (self?.currentPage)! + 1, link: searchUsersLink)
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
        cellViewModels += vms
    }
    
    func createViewModel(profileImageLink: String, userName: String, realName: String, id: String, updateDate: String, userPhotos: [UserPhoto])-> SearchedUserCellModel{
        return SearchedUserCellModel(profileImageLink: profileImageLink, userName: userName, realName: realName, id: id, updatedDate: updateDate, userPhotos: userPhotos)
    }
    
    func getViewModel(indexPath: IndexPath)-> SearchedUserCellModel{
        return cellViewModels[indexPath.row]
    }
}

extension SearchedUsersTableViewModel{
    func setCacheValue(page: Int, link: String){
        paginate_cache.setObject(link as NSString, forKey: page as NSNumber)
    }
    
    func paginate(page: Int, complete: @escaping (_ errorMessage: String)->()){
        let url = paginate_cache.object(forKey: page as NSNumber)! as String
        currentPage = page
        DispatchQueue.global(qos: .background).async {
            APIManager().decodeRequest(url: url, option: .user, complete: {
                [weak self] success, users, error in
                if success{
                    let users = users as! SearchedUsers
                    self?.fetchUser(users: users.results)
                    while searchUsersLink.last! != "="{
                        searchUsersLink.removeLast()
                    }
                    searchUsersLink += String((self?.currentPage)! + 1)
                    self?.setCacheValue(page: (self?.currentPage)! + 1, link: searchUsersLink)
                }
                else{
                    complete(error!)
                }
            })
        }
    }
}
