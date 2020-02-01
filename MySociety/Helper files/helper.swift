//
//  helper.swift
//  MySociety
//
//  Created by Admin on 09/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

var is_admin: Bool = false
var u_id: Int = 0
var userName: String = ""
var notificationBadgedCount: Int = 2

let loggedInUserIdDefaultKeyName = "loggedInUserId"
let loggedInUserNameDefaultKeyName = "loggedInUserName"
let loggedInUserIsAdminDefaultKeyName = "loggedInuserIsAdmin"
//boolValue = UserDefaults.standard.bool(forKey: loggedInUserIsAdminDefaultKeyName)
//UserDefaults.standard.set(true, forKey: loggedInUserIsAdminDefaultKeyName)

//let baseUrl = "https://cortexsolutions.co.in/mysociety/api/"
let baseUrl = "https://f8ed78ea.ngrok.io/society/api/"
let ngRokUrl: String = "https://f8ed78ea.ngrok.io/society/api/"
var globalHeaderValue = ["x-api-key": "1c552e6f2a95a883209e9b449d6f4973"]
//Update loggedInUserId everytime
var loggedInUserId = 1//UserDefaults.standard.integer(forKey: loggedInUserIdDefaultKeyName)
var isAdminLoggedIn = true//UserDefaults.standard.bool(forKey: loggedInUserIsAdminDefaultKeyName)
//MARK: Get badged label
func getBadgedLabelWithValue(count: Int) -> UILabel{
    //Badged set
    let label = UILabel(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
    label.layer.borderColor = UIColor.clear.cgColor
    label.layer.borderWidth = 2
    label.layer.cornerRadius = label.bounds.size.height / 2
    label.textAlignment = .center
    label.layer.masksToBounds = true
    label.textColor = .white
    label.font = label.font.withSize(12)
    label.backgroundColor = .red
    label.text = "\(count)"
    return label
}

func getRequestUrlWithHeader(url: String, method: String, header: [String: String], bodyParams: [String: Any]?) -> NSMutableURLRequest{
    let request = NSMutableURLRequest(url: NSURL(string: baseUrl+url)! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = method
    request.allHTTPHeaderFields = header
    if bodyParams != nil{
        let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams ?? ["":""])
        request.httpBody = jsonData
    }
    return request
}
