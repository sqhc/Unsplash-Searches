//
//  SearchedPhotosCollectionView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import UIKit

class SearchedPhotosCollectionView: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var viewModel: SearchedPhotosCollectionViewModel = {
        SearchedPhotosCollectionViewModel()
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
