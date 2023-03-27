//
//  SearchedPhotosCollectionView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import UIKit
import Dispatch

class SearchedPhotosCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        initVM()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photos_cache.removeAllObjects()
    }
    
    var viewModel: SearchedPhotosCollectionViewModel = {
        SearchedPhotosCollectionViewModel()
    }()
    
    func initVM(){
        viewModel.getPhotos(complete: {[weak self] errorMessage in
            let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in
                self?.present(alert, animated: true, completion: nil)
            }
        })
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.photosCollectionView.reloadData()
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
        return viewModel.photosCellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchedPhoto", for: indexPath) as? SearchedPhotoCell
        let cellVM = viewModel.getCellModel(indexPath: indexPath)
        cell?.photoImageView.setPhoto(image_link: cellVM.photo_url!)
        
        return cell!
    }
}

extension UIImageView{
    func setPhoto(image_link: String){
        DispatchQueue.global(qos: .background).async {
            if let photo = photos_cache.object(forKey: image_link as NSString){
                DispatchQueue.main.async {
                    self.image = photo
                }
            }
            else{
                guard let image_url = URL(string: image_link) else{
                    print("ERROR: The URL is not valid!")
                    return
                }
                URLSession.shared.dataTask(with: image_url, completionHandler: { data, response, error in
                    if error == nil{
                        photos_cache.setObject(UIImage(data: data!)!, forKey: image_link as NSString)
                        DispatchQueue.main.async {
                            if let data = data {
                                self.image = UIImage(data: data)
                            }
                        }
                    }
                    else{
                        print("ERROR: There is not data from the URL.")
                    }
                }).resume()
            }
        }
    }
}
