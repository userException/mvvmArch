//
//  ProfileViewModel.swift
//  MVVMArch
//

//

import Foundation

class ProfileViewModel{
    private var profile: Profile?
    
    let serviceClient: ProfileWebHooks
    
    //One to One mappings to be used by a controller, instead of the above model direclty to avoind any connection between controller and Model.
    var name: String
    
    init(with serviceCleint: ProfileWebHooks) {
        self.serviceClient = serviceCleint
        profile = nil
        name = ""
    }
    
    
    //MARK:- Services
    func refresh(completion: @escaping (Error?) -> Void){
        serviceClient.fetchProfileData { result in
            
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
