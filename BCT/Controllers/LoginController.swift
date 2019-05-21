//
//  LoginController.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation
class LoginController{
    
    
    func loginWithValues(email: String, name: String, publicKey: String, completion: @escaping ((_ user:LoginDataModel?, _ error: Error?) -> ())){
         let request = LoginRequest(params: ["email": email, "name": name, "publicKey": publicKey, "surname":" ", "userType":"PARTICIPANT"])
        request.execute(onSuccess: { (model) in
            completion(model.data,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
    
}
