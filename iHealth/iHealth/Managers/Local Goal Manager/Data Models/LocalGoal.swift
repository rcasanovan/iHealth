//
//  LocalGoal.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation
import RealmSwift

class LocalGoal: Object {
    
    @objc dynamic var goalId: String?
    @objc dynamic var title: String = ""
    @objc dynamic var goalDescription: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var goal: Int = 0
    @objc dynamic var trophy: String = ""
    @objc dynamic var points: Int = 0
    
    override class func primaryKey() -> String? {
        return "goalId"
    }
    
}
