//
//  GetAllListRequest.swift
//  BCT
//
//  Created by Mert Serin on 17.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

class GetAllListRequest:RequestType{
    
    typealias ResponseType = GetAllListResponseModel
    var data:RequestData
    
    init(params:[String:Any]) {
        data = RequestData(path: "/meeting/user-signatures", method: HTTPMethod.post, params: params, headers: nil)
    }
    
}
