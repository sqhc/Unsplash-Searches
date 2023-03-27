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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchUsersLink = "https://api.unsplash.com/search/users?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"
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
        if viewModel.query == ""{
            let alertView = UIAlertController(title: "No user name", message: "The user name shouldn't be empty, please fill in.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UsersTable") as? SearchedUsersTableView{
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
