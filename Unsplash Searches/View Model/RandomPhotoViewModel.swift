//
//  RandomPhotoViewModel.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/25/23.
//

import Foundation
import Dispatch

class RandomPhotoViewModel: NSObject{
    var photoLink = ""
    
    override init() {
        super.init()
    }
    
    func getRandomPhoto(complete: @escaping (_ errorMessage: String?, _ data: Data?)->()){
        DispatchQueue.global(qos: .background).async {
            APIManager().decodeRequest(url: searchRandomPhotoLink, option: .randomPhoto, complete: {
                [weak self] success, random, error in
                if success{
                    let randomPhoto = random as! RandomPhoto
                    self?.photoLink = randomPhoto.urls.full!
                    if let link = URL(string: self!.photoLink){
                        let task = URLSession.shared.dataTask(with: link, completionHandler: {
                            data, response, error in
                            if error != nil{
                                complete(error?.localizedDescription, nil)
                            }
                            if let data = data {
                                complete(nil, data)
                            }
                        })
                        task.resume()
                    }
                }
                else{
                    complete(error!, nil)
                }
            })
        }
    }
}
