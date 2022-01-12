//
//  HomeViewController.swift
//  AppUploadDocs
//
//  Created by Maria Fernanda Lopez on 30/12/21.
//
import UIKit
import SwiftUI

class HomeViewController: UIViewController {
        
    @AppStorage("stored_Name") var Stored_Name = ""
    
    let bllViewModel: AppViewModel
    
    @IBOutlet weak var nameUserLabel: UILabel!
    
    @EnvironmentObject var viewModel: AppViewModel

    init?(bllViewModel: AppViewModel, coder: NSCoder) {
        self.bllViewModel = bllViewModel
        super.init(coder: coder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameUserLabel.text = Stored_Name
        print(Stored_Name)
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation
    
    @IBAction func logOutBtnAction(_ sender: UIButton) {
        bllViewModel.signOut()
    }
    
   
}

