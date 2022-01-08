//
//  ResultViewDocument.swift
//  AppUploadDocs
//
//  Created by Maria Fernanda Lopez on 7/01/22.
//

import Foundation

struct ResultViewDocument : Decodable{
    let Count : Int
    let Items : [ViewDocument]
    let ScannedCount : Int
}

struct ViewDocument : Decodable, Hashable{
    let IdRegistro : String
    let Adjunto : String
    let TipoAdjunto : String

}
