//
//  ViewDocDetailController.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 7/01/22.
//

import UIKit

class ViewDocDetailController: UIViewController {
    
    let service = ServiceSophos()
    var objImage : ResultViewDocument?
    
    @IBOutlet weak var imgViewLabel: UILabel?
    
    @IBOutlet weak var imgViewDoc: UIImageView!
    var idRegistro : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        bllGetImage()

    }
    
    // MARK: - Funciones comunes
    // logica de negocio para obtener las ciudades
    private func bllGetImage() {
        service.getViewDocumentAPI(idResgistro: idRegistro)
        service.completionHandlerGetViewDoc { [weak self] (viewDocument, status, message) in
    
            if status {
                guard let self = self else {return}
                guard let _documents = viewDocument else {
                    print("No llego dato")
                    return}
                self.objImage = _documents
                
                self.setImage()
            }else {
                print(message)
            }
        }
    }
    
    fileprivate func setImage() {
        self.imgViewLabel?.text = self.objImage?.Items[0].TipoAdjunto
        
        guard let contentBase64 = self.objImage?.Items[0].Adjunto else {
            self.imgViewLabel?.text = "no descargo la imagen"
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if  contentBase64 != "" {
                
                DispatchQueue.main.async {
                    self?.imgViewDoc.image = self?.convertBase64ToImage(imageString: contentBase64)
                }
            } else {
                self?.imgViewLabel?.text = "no convertir la imagen"
            }
        }
    }
    
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString,
                             options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    
}
