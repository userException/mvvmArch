//
//  ProfileViewModel.swift
//  MVVMArch
//

//

import Foundation

class ProfileViewModel{
    private var profile: Profile?
    
    let webHook = ProfileServices()
    
    //One to One mappings to be used by a controller, instead of the above model direclty to avoind any connection between controller and Model.
    var name: String
    
    init() {
        name = ""
    }
    
    
    //MARK:- Public Access
    func refresh(completion: @escaping (Error?) -> Void){
        getProfileData { (error) in
            completion(error)
        }
    }
    
    //MARK:- Private Access
    fileprivate func getProfileData(completion: @escaping (Error?) -> Void){
        webHook.fetchProfileData { result in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let profileData, _):
                    if let profileData = profileData{
                        self.profile = profileData
                        self.name = profileData.name
                    }
                    completion(nil)
                    
                case .failure(let apiError):
                    completion(apiError)
                    
                }
            }
        }
    }
}
