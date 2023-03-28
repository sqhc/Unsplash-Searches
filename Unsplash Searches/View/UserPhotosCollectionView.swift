//
//  UserPhotosCollectionView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/27/23.
//

import UIKit
import Dispatch

class UserPhotosCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var userPhotosCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userPhotosCollectionView.delegate = self
        userPhotosCollectionView.dataSource = self
        
        self.title = "\(viewModel.delegate.getUserName())'s photos"
        
        initVM()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photos_cache.removeAllObjects()
    }
    
    var viewModel: UserPhotosCollectionViewModel = {
        UserPhotosCollectionViewModel()
    }()

    func initVM(){
        viewModel.getPhotos()
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.userPhotosCollectionView.reloadData()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPhoto", for: indexPath) as? UserPhotoCell
        
        let cellVM = viewModel.getCellModel(indexPath: indexPath)
        cell!.userPhotoImageView.setPhoto(image_link: cellVM.userPhotoLink!)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width - 250.0
        return CGSize(width: width, height: width / 1.1)
    }
}
