//
//  payMaintenanceSelectMemberSharedFile.swift
//  MySociety
//
//  Created by Admin on 26/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class payMaintenanceSelectMemberSharedFile{
    static let shared = payMaintenanceSelectMemberSharedFile()
    var memberSelectedName: String = "Select Member"
    var memberSelectedId: Int = 0
    var memberSelectedBalanceAmount: Float = 0
}
