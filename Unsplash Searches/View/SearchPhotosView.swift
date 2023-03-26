//
//  SearchPhotosView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/25/23.
//

import UIKit

class SearchPhotosView: UIViewController {
    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var pageTextField: UITextField!
    @IBOutlet weak var perPageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        queryTextField.delegate = self
        pageTextField.delegate = self
        perPageTextField.delegate = self
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
    @IBAction func order(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            viewModel.order = "relevant"
        case 1:
            viewModel.order = "latest"
        default:
            viewModel.order = ""
        }
    }
    
    @IBAction func random(_ sender: UIButton){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RandomPhoto") as? RandomPhotoView{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func search(_ sender: UIButton){
        
    }
}

extension SearchPhotosView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let value = textField.text else{
            return true
        }
        switch textField{
        case queryTextField:
            viewModel.query = value
        case pageTextField:
            viewModel.page = value
        case perPageTextField:
            viewModel.perPage = value
        default:
            return true
        }
        return true
    }
}
