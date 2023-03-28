//
//  APIManager.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/24/23.
//

import Foundation

class APIManager{
    func getData(url: String, complete: @escaping(_ success: Bool, _ data: Data?)->()){
        guard let searchURL = URL(string: url) else{
            complete(false, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: searchURL, completionHandler: { data, response, error in
            if error != nil{
                print("Error: problem for the GET request")
                print(error!.localizedDescription)
                complete(false, nil)
            }
            if let data = data {
                complete(true, data)
            }
            else{
                print("Error: did not receive any data")
                complete(false, nil)
            }
        })
        task.resume()
    }
    
    func decodeRequest(url: String, option: Request, complete: @escaping(_ success: Bool, _ result: Any?, _ errorMessage: String?)->()){
        switch option {
        case .collection:
            decodeCollection(url: url, complete: { success, collection, error in
                if success{
                    complete(true, collection, nil)
                }
                else{
                    complete(false, nil, error)
                }
            })
        case .photo:
            decodePhoto(url: url, complete: { success, photos, error in
                if success{
                    complete(true, photos, nil)
                }
                else{
                    complete(false, nil, error)
                }
            })
        case .user:
            decodeUser(url: url, complete: { success, users, error in
                if success{
                    complete(true, users, nil)
                }
                else{
                    complete(false, nil, error)
                }
            })
        case .randomPhoto:
            decodeRandomPhoto(url: url, complete: { success, randomPhoto, error in
                if success{
                    complete(true, randomPhoto, nil)
                }
                else{
                    complete(false, nil, error)
                }
            })
        case .collectionPhoto:
            decodeCollectionPhotos(url: url, complete: { success, collectionPhotos, error in
                if success{
                    complete(true, collectionPhotos, nil)
                }
                else{
                    complete(false, nil, error)
                }
            })
        }
    }
    
    func decodeCollection(url: String, complete: @escaping(_ success: Bool, _ collection: Collections?, _ errorMessage: String?)->()){
        getData(url: url){ success, data in
            if success{
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(Collections.self, from: data)
                        complete(true, model, nil)
                    }
                    catch{
                        complete(false, nil, error.localizedDescription)
                    }
                }
            }
            else{
                complete(false, nil, "The GET Request failed.")
            }
        }
    }
    
    func decodePhoto(url: String, complete: @escaping(_ success: Bool, _ photos: SearchedPhotos?, _ errorMessage: String?)->()){
        getData(url: url){ success, data in
            if success{
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(SearchedPhotos.self, from: data)
                        complete(true, model, nil)
                    }
                    catch{
                        complete(false, nil, error.localizedDescription)
                    }
                }
            }
            else{
                complete(false, nil, "The GET Request failed.")
            }
        }
    }
    
    func decodeRandomPhoto(url: String, complete: @escaping(_ success: Bool, _ random: RandomPhoto?,_ errorMessage: String?)->()){
        getData(url: url){ success, data in
            if success{
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(RandomPhoto.self, from: data)
                        complete(true, model, nil)
                    }
                    catch{
                        complete(false, nil, error.localizedDescription)
                    }
                }
            }
            else{
                complete(false, nil, "The GET Request failed.")
            }
        }
    }
    
    func decodeUser(url: String, complete: @escaping(_ success: Bool, _ users: SearchedUsers?, _ errorMessage: String?)->()){
        getData(url: url){ success, data in
            if success{
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(SearchedUsers.self, from: data)
                        complete(true, model, nil)
                    }
                    catch{
                        complete(false, nil, error.localizedDescription)
                    }
                }
            }
            else{
                complete(false, nil, "The GET Request failed.")
            }
        }
    }
    
    func decodeCollectionPhotos(url: String, complete: @escaping( _ success: Bool, _ photos: [SearchedPhoto]?, _ errorMessage: String?)->()){
        getData(url: url){success, data in
            if success{
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let model = try decoder.decode([SearchedPhoto].self, from: data)
                        complete(true, model, nil)
                    }
                    catch{
                        complete(false, nil, error.localizedDescription)
                    }
                }
            }
            else{
                complete(false, nil, "The GET Request failed.")
            }
        }
    }
}
