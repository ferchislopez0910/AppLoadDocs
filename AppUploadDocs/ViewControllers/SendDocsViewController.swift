/*
  SendDocsViewController.swift
  AppUploadDocs

  Created by Maria Fernanda Lopez on 3/01/22.
*/

import UIKit
import SwiftUI
import DropDown

class SendDocsViewController: UIViewController {
    
    // variables
    @AppStorage("stored_User") var Stored_Email = ""

    @IBOutlet weak var numberIDTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var sendDocBtn: UIButton!
    
    @IBOutlet weak var messageValidate: UILabel!
    
    
    // Document ID
    let TEXT_DEFAULT_DOCUMENTID = "Seleccione el tipo de documento"
    @IBOutlet weak var documentID: UITextField!
    @IBOutlet weak var vmdocumentIDDropDown:UIView!
    @IBOutlet weak var lbldocumentID:UILabel!
    let docID = ["CC", "TI", "CE", "PA"]
    let dropDowndocumentID = DropDown()
    
    
    // Cities
    let TEXT_DEFAULT_CITY = "Seleccione la ciudad"
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var vmCitiesDropDown:UIView!
    @IBOutlet weak var lblCities:UILabel!
    let cities = ["Medellín", "Bogotá"]
    let dropDownCities = DropDown()
    
    // Kind attach
    let TEXT_DEFAULT_ADD = "Seleccione el tipo de adjunto"
    @IBOutlet weak var add: UITextField!
    @IBOutlet weak var vmAddDropDown:UIView!
    @IBOutlet weak var lblAdd:UILabel!
    let addType = ["Certificado de Cuenta", "Cedula", "Factura", "Incapacidad"]
    let dropDownAdd = DropDown()
    
    // Attach document
    let TEXT_DEFAULT_ATTACHDOCUMENT = "📩 Tipo de adjunto"
    @IBOutlet weak var attach: UITextField!
    @IBOutlet weak var vmAttachDropDown:UIView!
    @IBOutlet weak var lblAttach:UILabel!
    let attachDoc = ["Tomar foto", "Cargar foto"]
    let dropDownAttach = DropDown()
    var imageBase64: String? = ""
    

    // Actions
    @IBAction func sendBtnAction(_ sender: UIButton) {
        
        /*
        print(documentID.text)
        print(numberIDTextField.text)
        print(nameTextField.text)
        print(lastNameTextField.text)
        print(emailTextField.text)
        print(city.text)
        print(add.text)
        */

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Setup View
        setupView()
        
        //config list documentID
        setupViewDocumentID()
        
        // config list cities
        setupViewCities()
        
        // config list add
        setupViewAdd()
        
        // config list attach
        setupViewAttach()
        
    }
  
  

    // MARK: - Show document ID
    
    @IBAction func showDocumentIDOption(_ sender: UIButton) {
        dropDowndocumentID.show()
    }
    
    // MARK: - Show cities
    
    @IBAction func showCitiesOption(_ sender: UIButton) {
        dropDownCities.show()
    }
    // MARK: - Show add
    @IBAction func showAddOption(_ sender: UIButton) {
        dropDownAdd.show()
    }
    
    // MARK: - Show attach document
    @IBAction func showAttachOption(_ sender: UIButton) {
        dropDownAttach.show()
    }
    
    
    // MARK: - Config show drop down document ID
    fileprivate func setupViewDocumentID() {
        lbldocumentID.text = TEXT_DEFAULT_ATTACHDOCUMENT
        dropDowndocumentID.anchorView = vmdocumentIDDropDown
        dropDowndocumentID.dataSource = docID
        dropDowndocumentID.bottomOffset = CGPoint(x: 0, y:(dropDowndocumentID.anchorView?.plainView.bounds.height)!)
        dropDowndocumentID.topOffset = CGPoint(x: 0, y:-(dropDowndocumentID.anchorView?.plainView.bounds.height)!)
        dropDowndocumentID.direction = .bottom
        // cuando le dan clic a la opcion
        dropDowndocumentID.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lbldocumentID.text = docID[index]
            self.documentID.text = docID[index]
            validateFieldDidChange(self.documentID)
        }
    }
    
    // MARK: - Config show drop down cities
    fileprivate func setupViewCities() {
        lblCities.text = TEXT_DEFAULT_CITY
        dropDownCities.anchorView = vmCitiesDropDown
        dropDownCities.dataSource = cities
        dropDownCities.bottomOffset = CGPoint(x: 0, y:(dropDownCities.anchorView?.plainView.bounds.height)!)
        dropDownCities.topOffset = CGPoint(x: 0, y:-(dropDownCities.anchorView?.plainView.bounds.height)!)
        dropDownCities.direction = .bottom
        // cuando seleccionan una opcion
        dropDownCities.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblCities.text = cities[index]
            self.city.text = cities[index]
            validateFieldDidChange(self.city)
        }
    }

    // MARK: - Config show drop down add
    fileprivate func setupViewAdd() {
        lblAdd.text = TEXT_DEFAULT_ADD
        dropDownAdd.anchorView = vmAddDropDown
        dropDownAdd.dataSource = addType
        dropDownAdd.bottomOffset = CGPoint(x: 0, y:(dropDownAdd.anchorView?.plainView.bounds.height)!)
        dropDownAdd.topOffset = CGPoint(x: 0, y:-(dropDownAdd.anchorView?.plainView.bounds.height)!)
        dropDownAdd.direction = .bottom
        // cuando se selecciona una opcion
        dropDownAdd.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblAdd.text = addType[index]
            self.add.text = addType[index]
            validateFieldDidChange(self.add)
        }
    }
    
    // MARK: - Config show drop down attach
    fileprivate func setupViewAttach() {
        lblAttach.text = TEXT_DEFAULT_ATTACHDOCUMENT
        dropDownAttach.anchorView = vmAttachDropDown
        dropDownAttach.dataSource = attachDoc
        dropDownAttach.bottomOffset = CGPoint(x: 0, y:(dropDownAttach.anchorView?.plainView.bounds.height)!)
        dropDownAttach.topOffset = CGPoint(x: 0, y:-(dropDownAttach.anchorView?.plainView.bounds.height)!)
        dropDownAttach.direction = .bottom
        // cuando seleccionan una opcion
        dropDownAttach.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblAttach.text = attachDoc[index]
            self.attach.text = attachDoc[index]
            validateFieldDidChange(self.attach)
            
            if(attachDoc[index] == "Cargar foto") {
                self.getDocLibrary()
            }else{
                self.getDocCamera()
            }
            
            
        }
    }
    // MARK: - Function for get document from library
    fileprivate func getDocLibrary() {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    // MARK: - Function for get document from library
    fileprivate func getDocCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera))  {
                
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        }else {
            print("Dispositivo no tiene camara")
            messageValidate.text = "Dispositivo no tiene camara"
            messageValidate.isHidden = false
        }
        
    }
    // MARK: - View Methods
    fileprivate func setupView() {
        // Configure Password Validation Label
        messageValidate.isHidden = true
        
        // textfield hidden Document ID for store data
        documentID.isHidden = true
        
        // textfield hidden city for store data
        city.isHidden = true
        
        // textfield hidden city for store data
        add.isHidden = true
        
        // textfield hidden attach document for store data
        attach.isHidden = true
        
        // Update Save Button
        sendDocBtn.isEnabled = false
        
        // set textField email
        emailTextField.text = Stored_Email
        
    }
    
    // MARK: - function that validate each fields
    @IBAction func validateFieldDidChange(_ sender: UITextField) {
        sendDocBtn.isEnabled = false
        messageValidate.isHidden = true
        messageValidate.text = ""
        
        if documentID.text == "" || documentID.text == TEXT_DEFAULT_DOCUMENTID {
            messageValidate.text = "El tipo de documento es obligatorio"
            messageValidate.isHidden = false
            return
        }
        if numberIDTextField.text == "" {
            messageValidate.text = "El número de identificacion es obligatorio"
            messageValidate.isHidden = false
            return
        }
        if nameTextField.text == "" {
            messageValidate.text = "El nombre es obligatorio"
            messageValidate.isHidden = false
            return
        }
        if lastNameTextField.text == "" {
            messageValidate.text = "El apellido es obligatorio"
            messageValidate.isHidden = false
            return
        }
        if emailTextField.text == "" {
            messageValidate.text = "El email es obligatorio"
            messageValidate.isHidden = false
            return
        }
        if !textFieldValidatorEmail((emailTextField.text) ?? "NA") {
            messageValidate.text = "El email no tiene el formato correcto"
            messageValidate.isHidden = false
            return
        }

        if city.text == "" || city.text == TEXT_DEFAULT_CITY {
            messageValidate.text = "La ciudad es obligatoria"
            messageValidate.isHidden = false
            return
        }
        
        //add
        if add.text == "" || add.text == TEXT_DEFAULT_ADD {
            messageValidate.text = "La tipo de adjunto es obligatoria"
            messageValidate.isHidden = false
            return
        }
        
        //attach
        if attach.text == "" || attach.text == TEXT_DEFAULT_ADD {
            messageValidate.text = "Adjuntar documento"
            messageValidate.isHidden = false
            return
        }
        
        //document attachment
        if imageBase64 == "" || imageBase64 == TEXT_DEFAULT_ADD {
            messageValidate.text = "Imagen no seleccionada"
            messageValidate.isHidden = false
            return
        }
        
        sendDocBtn.isEnabled = true
        messageValidate.isHidden = true
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
            
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // short format
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: string)
    }
    
    func convertImageToBase64(image: UIImage) -> String? {
        let imageData = image.jpegData(compressionQuality: 1)
        return imageData?.base64EncodedString(options:
                    Data.Base64EncodingOptions.lineLength64Characters)
    }
}



extension SendDocsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - when to upload an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        print("FROM ::: imagePickerController")
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            //print(image)
            imageBase64 = convertImageToBase64(image: image)
            validateFieldDidChange(attach)
        }else {
            messageValidate.text = "Image not found!"
            messageValidate.isHidden = false
            return
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
