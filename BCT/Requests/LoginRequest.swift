//
//  LoginRequest.swift
//  BCT
//
//  Created by Mert Serin on 16.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

class LoginRequest:RequestType{
    
    typealias ResponseType = LoginResponseModel
    var data:RequestData
    
    init(params:[String:Any]) {
        data = RequestData(path: "/user/create", method: HTTPMethod.post, params: params, headers: nil)
    }
    
}
