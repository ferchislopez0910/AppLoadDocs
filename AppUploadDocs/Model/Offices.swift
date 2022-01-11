//
//  Offices.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 10/01/22.
//

import Foundation

struct ResultOffice : Decodable{
    let Count : Int
    let Items : [Office]
}

struct Office : Codable{
    let Ciudad : String
    let Longitud : String
    let IdOficina : Int
    let Latitud : String
    let Nombre: String
}
