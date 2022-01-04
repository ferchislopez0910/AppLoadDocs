//
//  SendDocsViewController.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 3/01/22.
//

import UIKit
import DropDown

class SendDocsViewController: UIViewController {
    
  

    @IBOutlet weak var numberIDTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var sendDocBtn: UIButton!
    
    @IBOutlet weak var messageValidate: UILabel!
    
    // ciudades
    let TEXT_DEFAULT_CITY = "Seleccione la ciudad"
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var vmCitiesDropDown:UIView!
    @IBOutlet weak var lblCities:UILabel!
    let cities = ["Medellín", "Bogotá"]
    let dropDownCities = DropDown()

    //Actions
    
    @IBAction func sendBtnAction(_ sender: UIButton) {
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
        
        // config list cities
        setupViewCities()
    
    }
    
    // MARK: - Show cities
    
    @IBAction func showCitiesOption(_ sender: UIButton) {
        dropDownCities.show()
    }
    
    // MARK: - Config show drop down cities
    fileprivate func setupViewCities() {
        lblCities.text = TEXT_DEFAULT_CITY
        dropDownCities.anchorView = vmCitiesDropDown
        dropDownCities.dataSource = cities
        dropDownCities.bottomOffset = CGPoint(x: 0, y:(dropDownCities.anchorView?.plainView.bounds.height)!)
        dropDownCities.topOffset = CGPoint(x: 0, y:-(dropDownCities.anchorView?.plainView.bounds.height)!)
        dropDownCities.direction = .bottom
        dropDownCities.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblCities.text = cities[index]
            self.city.text = cities[index]
        }
    }
    
    // MARK: - View Methods

    fileprivate func setupView() {
        // Configure Password Validation Label
        messageValidate.isHidden = true
        
        // textfield hidden city for store data
        city.isHidden = true
        // Update Save Button
        sendDocBtn.isEnabled = false
        
    }
    
    @IBAction func validateFieldDidChange(_ sender: UITextField) {
        sendDocBtn.isEnabled = false
        messageValidate.isHidden = true
        messageValidate.text = ""
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
        
        sendDocBtn.isEnabled = true
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
            
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // short format
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: string)
    }
    
    
    
    
}

