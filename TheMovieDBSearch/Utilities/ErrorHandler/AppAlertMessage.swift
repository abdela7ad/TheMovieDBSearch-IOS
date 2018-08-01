//
//  AppAlertMessage.swift
//  TheMovieDBSearch
//
//  Created by Abdelahad on 7/29/18.
//  Copyright © 2018 Abdelahad. All rights reserved.
//

import Foundation
import UIKit


/// Protocal for Error Alerted to user it have Message and optional image

/// Encapsulate AlertableError in stuct with message and image
struct ErrorModel {
    let message:AppAlertMessage
    let image:UIImage?
    
    static func none()->ErrorModel{
        return ErrorModel(message: .none, image: nil)
    }
}


protocol AlertableError : Error {
    var errorModel:ErrorModel { get }
}


extension AlertableError{
    /// localized message
    var  localizedMessage : String {
        return errorModel.message.localized()
    }
    /// localized image 
    var  image : UIImage? {
        return errorModel.image
    }
}




/// Enum to have allmessage with row value as key in localization string
enum AppAlertMessage : String  {
    case internetConnection  = "No_Connection"
    case noSearchResults     = "No_Search_Results"
    case apiExpire           = "API_Expire"
    case none
    func localized() -> String {
        return self.rawValue.localized()
    }
}


