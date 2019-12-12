//
//  Series.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Cameron Rivera on 12/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct Series: Decodable{
    var show: Show?
}

struct Show: Decodable{
    var name: String?
    var id: Int?
    var image: Image?
}

struct Image: Decodable{
    var medium: String?
    var original: String?
}


