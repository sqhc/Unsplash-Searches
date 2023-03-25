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
