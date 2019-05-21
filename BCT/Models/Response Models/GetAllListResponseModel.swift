//
//  GetAllListResponseModel.swift
//  BCT
//
//  Created by Mert Serin on 17.05.2019.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import Foundation

class GetAllListResponseModel:Codable{
    
    var data:[ListModel]
    
}

class ListModel:Codable{
    var id:Int
    var creationDate:Date
    var updateDate:Date
    var signStatus:String
    var meeting:ListMeetingModel
    var user:ListUserModel
    
}

class ListMeetingModel:Codable{
    var id:Int
    var creationDate:Date
    var updateDate:Date
    var meetingId:String
    var subject:String
    var fileName:String
    var publicKey:String
    var hash:String
    var reportUrl:String
    var status:String
    var creatorEmail:String
    var transactionHash:String?
    var ledgerId:Int?
}

class ListUserModel:Codable{
    var id:Int
    var creationDate:Date
    var updateDate:Date
    var username:String
    var name:String
    var surname:String
    var email:String
    var publicKey:String
    var userType:String
}
