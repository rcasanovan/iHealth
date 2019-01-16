//
//  HealthProtocols.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

typealias HealthAuthCompletionBlock = (_ success: Bool, _ error: Error?) -> Void
typealias HealthGetValueCompletionBlock = (_ value: Double, _ success: Bool) -> Void

protocol HealthDelegate: class {
    func requestAuthorization(completion: @escaping HealthAuthCompletionBlock)
    func getValueForType(_ type: HealthValueType, completion: @escaping HealthGetValueCompletionBlock)
}
