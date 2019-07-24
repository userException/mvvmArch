//
//  ProfileNetworking.swift
//  MVVMArch
//

//

import Foundation


class ProfileServices{
    
    func fetchProfileData(completion: @escaping (Result<(Profile?,URLResponse?), Error>) -> Void){
        
        //If this URL is itself wrong, we need to crash the app right now with force unwrapping. This is something we are hardcoding and which should be confidently correct, without unncessary optional unwrapping.
        
        let postURL = URL.init(string: "https://my-json-server.typicode.com/typicode/demo/profile")!
        
        NetworkHandler.shared.getData(from: postURL) { (apiData, apiResponse, apiError) in
            
            if let apiError = apiError{
                completion(.failure(apiError))
                return
            }
            
            guard let apiData = apiData else {
                completion(.failure(ServerError.emptyResponse))
                return
            }
            
            do{
                let profileData = try JSONDecoder().decode(Profile.self, from: apiData)
                completion(.success((profileData, apiResponse)))
            }
            catch{
                completion(.failure(ServerError.parsingError))
            }
        }
    }
}
