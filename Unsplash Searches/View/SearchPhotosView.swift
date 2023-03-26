//
//  SearchPhotosView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/25/23.
//

import UIKit

class SearchPhotosView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchPhotosLink = "https://api.unsplash.com/search/photos?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"
    }
    
    var viewModel: PhotoSearchViewModel = {
        PhotoSearchViewModel()
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func random(_ sender: UIButton){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RandomPhoto") as? RandomPhotoView{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
