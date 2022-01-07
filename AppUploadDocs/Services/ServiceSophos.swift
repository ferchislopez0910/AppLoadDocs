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
    
    // MARK: - variable que completara el servicio con los datos obtenidos de la API
    typealias citiesCallBack = (_ cities: ResultCities?, _ status: Bool, _ message:String) -> Void
    var callBackCity:citiesCallBack?
    
    typealias sendDocCallBack = (_ status: Bool, _ message:String) -> Void
    var callBackSendDoc:sendDocCallBack?
    
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
    
    
    
    // MARK: - completionHandlerCity para llenar la variable que nos envian desde el consumidor de la funcion getCitiesAPI
    func completionHandlerGetCities(callBack: @escaping citiesCallBack) {
        self.callBackCity = callBack
        
    }
    
    // MARK: - completionHandlerCity para llenar la variable que nos envian desde el consumidor de la funcion getCitiesAPI
    func completionHandlerSendDoc(callBack: @escaping sendDocCallBack) {
        self.callBackSendDoc = callBack
    }
    
        
        
}

