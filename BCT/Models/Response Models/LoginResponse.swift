//
//  LoginResponse.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

class LoginResponseModel:Codable{
    
    var data:LoginDataModel
    
}

class LoginDataModel:Codable{
    
    var id:Int
    var username:String
    var email:String
    var publicKey:String
    var userType:String
    
}
