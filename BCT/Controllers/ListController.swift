//
//  ListController.swift
//  BCT
//
//  Created by Mert Serin on 17.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

class ListController{
    
    
    func getAllList(username:String, completion:@escaping ((_ list:GetAllListResponseModel?, _ error:Error?) -> ())){
        let request = GetAllListRequest(params: ["username":username])
        request.execute(onSuccess: { (model) in
            completion(model,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
    
    func getMeetingSignatures(meetingId:Int, username:String, completion:@escaping ((_ list:GetAllListResponseModel?, _ error:Error?) -> ())){
        let request = ListRecepientsRequest(id: meetingId, params: nil)
        request.execute(onSuccess: { (model) in
            completion(model,nil)
        }) { (error) in
            completion(nil,error)
        }
    }
    
    func signDocument(username:String, signedHash:String, meetingId:String, completion:@escaping ((_ error:Error?) -> ())){
        let params = ["meetId":meetingId, "signedHash":signedHash, "username":username]
        let request = SignDocumentRequest(params: params)
        request.execute(onSuccess: { (model) in
            completion(nil)
        }) { (error) in
            completion(error)
        }
    }
    
}
