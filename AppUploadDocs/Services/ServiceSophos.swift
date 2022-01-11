//
//  ServiceSophos.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 6/01/22.
//

import Foundation
import Alamofire

class ServiceSophos {
    fileprivate let UrlGetCities = "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Oficinas"
    fileprivate let UrlGetOffice = "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Oficinas"
    fileprivate let UrlPostDocument = "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Documentos"
    fileprivate let UrlGetDocuments = "https://6w33tkx4f9.execute-api.us-east-1.amazonaws.com/RS_Documentos"
    
    
    // MARK: - variable que completara el servicio con los datos obtenidos de la API
    typealias citiesCallBack = (_ cities: ResultCities?, _ status: Bool, _ message:String) -> Void
    var callBackCity:citiesCallBack?
    
    typealias officesCallBack = (_ offices: ResultOffice?, _ status: Bool, _ message:String) -> Void
    var callBackOffices:officesCallBack?
  
    
    typealias sendDocCallBack = (_ status: Bool, _ message:String) -> Void
    var callBackSendDoc:sendDocCallBack?
    
    typealias documentCallBack = (_ document: ResultDocuments?, _ status: Bool, _ message:String) -> Void
    var callBackDocument : documentCallBack?
    
    typealias viewDocumentCallBack = (_ viewDocument: ResultViewDocument?, _ status: Bool, _ message:String) -> Void
    var callBackViewDocument : viewDocumentCallBack?
  
    
    init(){}
    
    
    // MARK: - getCitiesAPI
    func getCitiesAPI(){
        print("Running getCitiesAPI")
        guard let endpointCities = URL(string: UrlGetCities) else{
            print("URL no valida")
            return
        }
        
        AF.request(endpointCities, method: .get, parameters: nil, encoding: JSONEncoding.default).response {(responseData) in
            // validar que si llega la data de la API
            guard let data = responseData.data else {
                print("no data - getCities")
                self.callBackCity?(nil, false, "no data - getCities")
                return
            }
            do {
                // serializar la data en el modelo
                let cities = try JSONDecoder().decode(ResultCities.self, from: data)
                self.callBackCity?(cities, true, "")
                
            } catch {
                print(error)
                self.callBackCity?(nil, false, error.localizedDescription)
            }
        }
    }
    
    // MARK: - getDocumentsAPI
    func getDocumentsAPI(email : String!){
        print("Running getDocumentsAPI")
        let UrlGetDocuments = UrlGetDocuments + "?correo=" + email
        guard let endpointGetDocuments = URL(string: UrlGetDocuments) else{
            print("URL no valida")
            return
        }
        
        AF.request(endpointGetDocuments, method: .get, parameters: nil, encoding: JSONEncoding.default).response {(responseData) in
            // validar que si llega la data de la API
            guard let data = responseData.data else {
                print("no data - getDocument")
                self.callBackDocument?(nil, false, "no data - getDocument")
                return
            }
            do {
                // serializar la data en el modelo
                let document = try JSONDecoder().decode(ResultDocuments.self, from: data)
                self.callBackDocument?(document, true, "")
                
            } catch {
                print(error)
                self.callBackDocument?(nil, false, error.localizedDescription)
            }
        }
    }
    
    // MARK: - sendDocumentAPI
    func sendDocumentAPI(TipoId:String!, Identificacion:String!, Nombre:String!, Apellido:String!, Ciudad:String!, Correo:String!, TipoAdjunto: String!, Adjunto:String!){
        print("Running sendDocumentAPI")
        
        let parameters: Parameters = [
            "TipoId": TipoId!,
            "Identificacion": Identificacion!,
            "Nombre": Nombre!,
            "Apellido": Apellido!,
            "Ciudad": Ciudad!,
            "Correo": Correo!,
            "TipoAdjunto": TipoAdjunto!,
            "Adjunto": Adjunto!
        ]
        
        guard let endpointDocument = URL(string: UrlPostDocument) else{
            print("URL no valida")
            self.callBackSendDoc?(false, "URL no valida")
            return
        }
        
        AF.request(endpointDocument, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                //debugPrint(response)
                switch response.result {
                case .success:
                    print("Carga Exitosa")
                    self.callBackSendDoc?(true, "")
                case let .failure(error):
                    self.callBackSendDoc?(false, error.localizedDescription)
                }
            }
        }
    

    // MARK: - getViewDocumentAPI
    func getViewDocumentAPI(idResgistro : String!){
        print("Running getViewDocumentAPI - download image")
        let UrlGetViewDocument = UrlGetDocuments + "?idRegistro=" + idResgistro
        guard let endpointGetViewDocuments = URL(string: UrlGetViewDocument) else{
            print("URL no valida")
            return
        }
        
        AF.request(endpointGetViewDocuments, method: .get, parameters: nil, encoding: JSONEncoding.default).response {(responseData) in
            
            //debugPrint(responseData)
            // validar que si llega la data de la API
            guard let data = responseData.data else {
                print("no data - getDocument")
                self.callBackViewDocument?(nil, false, "no data - getDocument")
                
                return
            }
            do {
                // serializar la data en el modelo
                let viewDocument = try JSONDecoder().decode(ResultViewDocument.self, from: data)
                self.callBackViewDocument?(viewDocument, true, "")
                
            } catch {
                print(error)
                self.callBackViewDocument?(nil, false, error.localizedDescription)
            }
        }
    }

    // MARK: - getOfficesAPI
    func getOfficesAPI(){
        print("Running getOfficesAPI")
        guard let endpointOffices = URL(string: UrlGetOffice) else{
            print("URL no valida")
            return
        }
        
        AF.request(endpointOffices, method: .get, parameters: nil, encoding: JSONEncoding.default).response {(responseData) in
            // validar que si llega la data de la API
            guard let data = responseData.data else {
                print("no data - getOfficesAPI")
                self.callBackOffices?(nil, false, "no data - getOfficesAPI")
                return
            }
            do {
                // serializar la data en el modelo
                let offices = try JSONDecoder().decode(ResultOffice.self, from: data)
                self.callBackOffices?(offices, true, "")
                
            } catch {
                print(error)
                self.callBackOffices?(nil, false, error.localizedDescription)
            }
        }
    }
    
    // MARK: - completionHandlerCity para llenar la variable que nos envian desde el consumidor de la funcion getCitiesAPI
    func completionHandlerGetCities(callBack: @escaping citiesCallBack) {
        self.callBackCity = callBack
        
    }
    
    // MARK: - completionHandlerCity para llenar la variable que nos envian desde el consumidor de la funcion getCitiesAPI
    func completionHandlerSendDoc(callBack: @escaping sendDocCallBack) {
        self.callBackSendDoc = callBack
    }
    
    // MARK: - completionHandlerGetDoc para llenar la variable que nos envian desde el consumidor de la funcion getDocAPI
    func completionHandlerGetDoc(callBack: @escaping documentCallBack) {
        self.callBackDocument = callBack
        
    }
    
    // MARK: - completionHandlerGetViewDoc para llenar la variable que nos envian desde el consumidor de la funcion getDocAPI
    func completionHandlerGetViewDoc(callBack: @escaping viewDocumentCallBack) {
        self.callBackViewDocument = callBack
        
    }
    
    // MARK: - completionHandlerGetOffices para llenar la variable que nos envian desde el consumidor de la funcion getOfficeAPI
    func completionHandlerGetOffices(callBack: @escaping officesCallBack) {
        self.callBackOffices = callBack
        
    }
    
        
        
}

