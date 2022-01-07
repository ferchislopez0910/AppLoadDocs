//
//  City.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 6/01/22.
//

import Foundation

struct ResultCities : Decodable{
    let Count : Int
    let Items : [City]
}

struct City : Decodable, Hashable{
    let Ciudad : String
}
