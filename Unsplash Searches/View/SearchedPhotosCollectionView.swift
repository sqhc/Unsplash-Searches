//
//  SearchedPhotosCollectionView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import UIKit
import Dispatch

class SearchedPhotosCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    var loading = true
    
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
        paginate_cache.removeAllObjects()
    }
    
    var viewModel: SearchedPhotosCollectionViewModel = {
        SearchedPhotosCollectionViewModel()
    }()
    
    func initVM(){
        viewModel.formAPI()
        viewModel.getPhotos(complete: {[weak self] errorMessage in
            let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in
                self?.present(alert, animated: true, completion: nil)
            }
        })
        viewModel.reloadCollectionView = { [weak self] in
            self?.loading = false
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
        if loading{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadPhotos", for: indexPath) as? PhotosLoadingCell
            cell!.photosLoadingActivity.startAnimating()
            return cell!
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchedPhoto", for: indexPath) as? SearchedPhotoCell
            let cellVM = viewModel.getCellModel(indexPath: indexPath)
            cell?.photoImageView.setPhoto(image_link: cellVM.photo_url!)
            
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width - 250.0
        return CGSize(width: width, height: width / 1.1)
    }
    
    @IBAction func paginate(_ sender: UIButton){
        loading = true
        if viewModel.current_page <= viewModel.allPage{
            viewModel.paginate(page: viewModel.current_page + 1, complete: {[weak self] errorMessage in
                let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(alertAction)
                DispatchQueue.main.async { [weak self] in
                    self?.present(alert, animated: true, completion: nil)
                }}
            )
        }
        else{
            let alert = UIAlertController(title: "Reach the end!", message: "This is the last page", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
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
