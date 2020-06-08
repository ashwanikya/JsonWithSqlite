//
//  TestApp
//
//  Created by ashwani yadav on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//
import Foundation



struct UserDetail {
    var userName: String
    var userID: String
}
struct LoginAnalyticsDetails {
    var email : String
    var isSuccess : Bool
    var deviceType : String
    var deviceOS : String
    var failureReason : String?
    
    init(email: String, isSuccess: Bool, deviceType: String, deviceOS: String) {
        self.email = email
        self.isSuccess = isSuccess
        self.deviceType = deviceType
        self.deviceOS = deviceOS
    }
}

class AshwaniAnalytics{
    
    private let serialQueue = DispatchQueue(label: "com.ashwani.analytics.segment")
   
    static let sharedInstance: AshwaniAnalytics = {

        return AshwaniAnalytics()
    }()
    
    func logEvent(logName : String){
        serialQueue.async{
           
        }
    }
   
   
    
    
}
