//
//  HomeViewController.swift
//  AppUploadDocs
//
//  Created by Maria Fernanda Lopez on 30/12/21.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    let bllViewModel: AppViewModel
    
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
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    @IBAction func signOutBtm(_ sender: UIButton) {
        bllViewModel.signOut()
    }
    
    @IBAction func goViewDocBtn(_ sender: Any) {
    
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
