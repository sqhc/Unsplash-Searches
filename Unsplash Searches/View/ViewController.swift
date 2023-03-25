//
//  ViewController.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/22/23.
//

import UIKit

class ViewController: UIViewController {
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
        searchCollectionsLink = "https://api.unsplash.com/search/collections?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"
    }

    var viewModel = {
        CollectionSearchViewModel()
    }()
    
    @IBAction func search(_ sender: UIButton){
        if viewModel.query == ""{
            let alertView = UIAlertController(title: "No topic", message: "The topic should be empty, please fill in.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchCollection") as? CollectionsTableView{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let value = textField.text else{
            return true
        }
        switch textField{
        case queryTextField:
            viewModel.query = value
            print(viewModel.query)
        case pageTextField:
            viewModel.page = value
            print(viewModel.page)
        case perPageTextField:
            viewModel.perPage = value
            print(viewModel.perPage)
        default:
            return true
        }
        return true
    }
}
