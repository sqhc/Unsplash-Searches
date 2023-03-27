//
//  SearchUsersView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/26/23.
//

import UIKit

class SearchUsersView: UIViewController {
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
    
    var viewModel: UsersSearchViewModel = {
        UsersSearchViewModel()
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func search(_ sender: UIButton){
        
    }
}

extension SearchUsersView: UITextFieldDelegate{
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
