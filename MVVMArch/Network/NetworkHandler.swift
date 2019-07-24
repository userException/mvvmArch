//
//  NetworkHandler.swift
//  MVVMArch
//

//

import Foundation

enum ServerError: Error{
    case emptyResponse
    case parsingError
    
    func localizedDescription() -> String{
        switch self {
        case .emptyResponse:
            return "Server error. Please contact the admin."
        case .parsingError:
            return "Invalid response from server."
        }
    }
}

class NetworkHandler{
    
    private init() {}
    
    static let shared = NetworkHandler()
    
    func getData(from targetURL: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void){
        
        URLSession.shared.dataTask(with: targetURL) { (apiData, apiResponse, apiError) in
            completion(apiData, apiResponse, nil)
        }.resume()
    }
}
