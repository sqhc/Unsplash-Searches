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
                complete(false, nil, "The GET Request failed")
            }
        }
    }
}
