//
//  Globals.swift
//  Unsplash Searches
//
//  Created by 沈清昊 on 3/23/23.
//

import Foundation
import UIKit

enum Request{
    case collection
    case photo
    case randomPhoto
    case user
}

var searchCollectionsLink = "https://api.unsplash.com/search/collections?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"
var searchPhotosLink = "https://api.unsplash.com/search/photos?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"
var searchRandomPhotoLink = "https://api.unsplash.com/photos/random?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"
var searchUsersLink = "https://api.unsplash.com/search/users?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"

var client_id = "?client_id=pyMs87cvZKpi4JmARh-uebHiGE14Ahepb89fQmJ0cvw"

let photos_cache = NSCache<NSString, UIImage>()
