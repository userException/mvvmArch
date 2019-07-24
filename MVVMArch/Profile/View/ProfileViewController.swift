//
//  ViewController.swift
//  MVVMArch
//

//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var btnRefresh: UIButton!
    @IBOutlet weak var activityIndicatorRefresh: UIActivityIndicatorView!
    @IBOutlet weak var lblProfile: UILabel!
    
    public var profileBridge: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBAction
    @IBAction func tapRefresh(_ sender: Any) {
        
        updateUIState(inProgress: true)
        
        profileBridge?.refresh(completion: { (apiError) in
            
            self.updateUIState(inProgress: false)
            
            if let apiError = apiError{
                self.lblProfile.text = apiError.localizedDescription
            }else{
                self.updateUIData()
            }
        })
    }
    
    //MARK:- UI
    func updateUIState(inProgress : Bool){
        
        btnRefresh.isUserInteractionEnabled = !inProgress
        activityIndicatorRefresh.isHidden = !inProgress
        
        if (inProgress){
            lblProfile.text = ""
            activityIndicatorRefresh.startAnimating()
        }else{
            activityIndicatorRefresh.stopAnimating()
        }
    }
    
    func updateUIData(){
        lblProfile.text = profileBridge?.name
    }
    
}

