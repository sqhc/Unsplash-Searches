//
//  CollectionPhotosCollectionView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/28/23.
//

import UIKit

class CollectionPhotosCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionPhotosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionPhotosCollectionView.delegate = self
        collectionPhotosCollectionView.dataSource = self
        
        self.title = "\(viewModel.delegate.getTitle())'s photos"
        
        initVM()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photos_cache.removeAllObjects()
    }
    
    var viewModel: CollectionPhotosCollectionViewModel = {
        CollectionPhotosCollectionViewModel()
    }()
    
    func initVM(){
        viewModel.getPhotos(complete: {[weak self] errorMessage in
            let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in
                self?.present(alert, animated: true, completion: nil)
            }})
        
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionPhotosCollectionView.reloadData()
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
        return viewModel.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionPhoto", for: indexPath) as? CollectionPhotoCell
        
        let cellVM = viewModel.getCellModel(indexPath: indexPath)
        cell!.collectionPhotoImageView.setPhoto(image_link: cellVM.photoLink!)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width - 250.0
        return CGSize(width: width, height: width / 1.1)
    }
}
