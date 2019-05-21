//
//  SignDocumentRequest.swift
//  BCT
//
//  Created by Mert Serin on 17.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

class SignDocumentRequest:RequestType{
    
    typealias ResponseType = ListRecepientsResponseModel
    var data:RequestData
    
    init(params:[String:Any]?) {
        data = RequestData(path: "/meeting/sign", method: HTTPMethod.post, params: params, headers: nil)
    }
    
}
