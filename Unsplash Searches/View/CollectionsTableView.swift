//
//  CollectionsTableView.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/24/23.
//

import UIKit
import Dispatch

class CollectionsTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var collectionsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionsTable.delegate = self
        collectionsTable.dataSource = self
        
        initVM()
    }
    
    var viewModel: CollectionsTableViewModel = {
        CollectionsTableViewModel()
    }()

    func initVM(){
        viewModel.getCollections(complete: {[weak self] errorMessage in
            let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in 
                self?.present(alert, animated: true, completion: nil)
            }
        })
        viewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.collectionsTable.reloadData()
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.collectionsCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collection", for: indexPath) as? CollectionsCell
        cell?.cellViewModel = viewModel.getCellModel(indexPath: indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = viewModel.getCellModel(indexPath: indexPath)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionPhotos") as? CollectionPhotosCollectionView{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
