//
//  ClientSophos.swift
//  AppUploadDocs
//  Modelo que recibe los datos de la API
//  Created by Valeria Castaño on 27/12/21.
//

import Foundation



struct ClientSophos: Codable {
    let id: String
    let nombre: String
    let apellido: String
    let acceso: Bool
    let admin: Bool
}
