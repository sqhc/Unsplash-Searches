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
    var loading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionsTable.delegate = self
        collectionsTable.dataSource = self
        
        initVM()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        paginate_cache.removeAllObjects()
    }
    var viewModel: CollectionsTableViewModel = {
        CollectionsTableViewModel()
    }()

    func initVM(){
        viewModel.formAPI()
        viewModel.getCollections(complete: {[weak self] errorMessage in
            let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in 
                self?.present(alert, animated: true, completion: nil)
            }
        })
        viewModel.reloadTableView = {[weak self] in
            self?.loading = false
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
        if loading{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadCollections", for: indexPath) as? CollectionLoadingCell
            cell!.loadActivity.startAnimating()
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "collection", for: indexPath) as? CollectionsCell
            cell?.cellViewModel = viewModel.getCellModel(indexPath: indexPath)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVM = viewModel.getCellModel(indexPath: indexPath)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionPhotos") as? CollectionPhotosCollectionView{
            vc.viewModel.delegate = cellVM
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func loadPagination(_ sender: UIButton){
        loading = true
        if viewModel.currentPage <= viewModel.allPage{
            viewModel.paginate(page: viewModel.currentPage + 1, complete: {[weak self] errorMessage in
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
