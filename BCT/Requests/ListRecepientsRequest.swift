//
//  ListRecepientsRequest.swift
//  BCT
//
//  Created by Mert Serin on 17.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

class ListRecepientsRequest:RequestType{
    
    typealias ResponseType = GetAllListResponseModel
    var data:RequestData
    
    init(id:Int, params:[String:Any]?) {
        data = RequestData(path: "/meeting/signatures?meetingId=\(id)", method: HTTPMethod.get, params: params, headers: nil)
    }
    
}
