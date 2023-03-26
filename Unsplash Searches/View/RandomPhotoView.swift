//
//  RandomPhotoView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/25/23.
//

import UIKit
import Dispatch

class RandomPhotoView: UIViewController {

    @IBOutlet weak var randomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initVM()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    var viewModel: RandomPhotoViewModel = {
        RandomPhotoViewModel()
    }()

    func initVM(){
        viewModel.getRandomPhoto(complete: { [weak self] error, data in
            if error == nil{
                DispatchQueue.main.async {
                    self?.randomImageView.image = UIImage(data: data!)
                }
            }
            else{
                let alertView = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertView.addAction(alertAction)
                DispatchQueue.main.async {
                    self?.present(alertView, animated: true, completion: nil)
                }
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
