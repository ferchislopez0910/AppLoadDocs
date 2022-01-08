//
//  ResultDocuments.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 7/01/22.
//

import Foundation

struct ResultDocuments : Decodable{
    let Count : Int
    let Items : [Document]
    let ScannedCount : Int
}

struct Document : Decodable, Hashable{
    let IdRegistro : String
    let Fecha : String
    let TipoAdjunto : String
    let Nombre : String
    let Apellido : String
}
