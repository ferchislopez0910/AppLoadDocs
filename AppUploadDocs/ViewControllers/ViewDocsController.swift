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
    
   
    let service = ServiceSophos()
    var objDocuments : ResultDocuments?
    
    
    @AppStorage("stored_User") var Stored_Email = ""

    // MARK: - Navigation
    @IBOutlet weak var tableViewDocs: UITableView!
    
    /*
     Implementar el DataSource -> interfaz
     */
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableViewDocs.dataSource = self
        
        // call API bllGetDocument
        bllGetDocument()
        
        // Implementar el delagte para que muestre el documento
        tableViewDocs.delegate = self
        
       
        
    }
    
    // MARK: - Funciones comunes
    // logica de negocio para obtener las ciudades
    private func bllGetDocument() {
        service.getDocumentsAPI(email: Stored_Email)
        service.completionHandlerGetDoc { [weak self] (document, status, message) in
    
            if status {
                guard let self = self else {return}
                guard let _documents = document else {
                    print("No llego dato")
                    return}
                self.objDocuments = _documents
                self.tableViewDocs.reloadData()
            }else {
                print(message)
            }
        }
    }
    
   
}


// MARK: - UITableViewDelegate metodo para generar la interaccion
// MARK: - UITableViewDataSource - UITableViewDelegate
extension ViewDocsController: UITableViewDelegate, UITableViewDataSource{
    /* Numero de filas que tendra la tabla - metodo que le dice a la tabla cuantas filas
     va a mostrar, esta se debe llenar a medida que se suben un archivo
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objDocuments?.Count ?? 0
    }
    
    /*
     * Metodo que indica las filas a mostrar
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = tableViewDocs.dequeueReusableCell(withIdentifier: "list-docs")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "list-docs")
            }
        
        let document = objDocuments?.Items[indexPath.row]
        
        let strFecha = formatDate(inputDate : document?.Fecha ?? "")

        
        cell?.textLabel?.text = "\(strFecha)" + " - " + (document?.TipoAdjunto ?? "")
        cell?.detailTextLabel?.text = (document?.Nombre ?? "") + " " + (document?.Apellido ?? "")
            
        
        return cell!
    }
   // MARK: - tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let document = objDocuments?.Items[indexPath.row]
        let vcDocDetail = storyboard?.instantiateViewController(withIdentifier: "ViewDocDetailController") as? ViewDocDetailController
        
        vcDocDetail?.idRegistro = document?.IdRegistro ?? ""
        navigationController?.pushViewController(vcDocDetail!, animated: true)
        
        
    }
    
    // MARK: -func formatDate
    
    private func formatDate(inputDate : String!) -> String{
        // intance class
        let dateFormatter = DateFormatter()
        
        // format current date string
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // convert string to Date
        let date = dateFormatter.date(from: inputDate ?? "")
        
        // format date requiere
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // convert Date to String
        return dateFormatter.string(from: date ?? Date())
        
        
    }
}

