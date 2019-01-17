//
//  GeneralMessageProtocols.swift
//
//  Created by Ricardo Casanova on 07/09/2018.
//

import Foundation

// View / Presenter
protocol GeneralMessageViewInjection : class {
    func load(title: String, message: String)
}

protocol GeneralMessagePresenterDelegate : class {
    func viewDidLoad()
}
