//
//  SearchedUsersTableView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import UIKit
import Dispatch

class SearchedUsersTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var UsersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UsersTableView.delegate = self
        UsersTableView.dataSource = self
        
        initVM()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photos_cache.removeAllObjects()
    }
    
    var viewModel: SearchedUsersTableViewModel = {
        SearchedUsersTableViewModel()
    }()
    
    func initVM(){
        viewModel.getUsers(complete: { [weak self] errorMessage in
            let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in
                self?.present(alert, animated: true, completion: nil)
            }
        })
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.UsersTableView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searhedUser", for: indexPath) as? SearchedUserCell
        
        let cellVM = viewModel.getViewModel(indexPath: indexPath)
        cell!.cellModel = cellVM
        cell!.UserProfileImageView.setPhoto(image_link: cellVM.profileImageLink!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = viewModel.getViewModel(indexPath: indexPath)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UserPhotos") as? UserPhotosCollectionView{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
