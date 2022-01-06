//
//  ViewDocsController.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 5/01/22.
//

import UIKit
import SwiftUI
import Foundation



class ViewDocsController: UIViewController {
    
    var date_ = Date()    
    
    @AppStorage("stored_Name") var Stored_Name = ""
    @AppStorage("stored_LastName") var Stored_LastName = ""

    // MARK: - Navigation
    @IBOutlet weak var tableViewDocs: UITableView!
    
    /*
     Implementar el DataSource -> interfaz
     */
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableViewDocs.dataSource = self
        tableViewDocs.register(UITableViewCell.self, forCellReuseIdentifier: "list-docs")
        
        // Implementar el delagte para que muestre el documento
        
        tableViewDocs.delegate = self
    }
}
// MARK: - UITableViewDelegate metodo para generar la interaccion
extension UIViewController: UITableViewDelegate{
    // metodo se activa cuando selecciono una celda (muestra el documentos)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Mostrar documento selecccionado \(indexPath.row + 1) ")
    }
}


// MARK: - UITableViewDataSource
extension ViewDocsController: UITableViewDataSource{
    /* Numero de filas que tendra la tabla - metodo que le dice a la tabla cuantas filas
     va a mostrar, esta se debe llenar a medida que se suben un archivo
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    /*
     * Metodo que indica las filas a mostrar
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewDocs.dequeueReusableCell(withIdentifier: "list-docs", for: indexPath)
        
        // TODO: addType = traer la variable tipo de documento - GET /RS_Documentos.

        cell.textLabel?.text = "\(date_.self)\(indexPath.row) \(Stored_Name) \(Stored_LastName)"
        
        return cell
    }
}
