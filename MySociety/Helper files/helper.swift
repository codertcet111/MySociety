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
