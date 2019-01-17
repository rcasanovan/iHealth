//
//  MyGoalDatasource.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

import UIKit

class MyGoalsDatasource: NSObject {
    
    public var myGoals: [MyGoalViewModel]
    
    public override init() {
        myGoals = []
        super.init()
    }
    
}

extension MyGoalsDatasource {
    
    private func generateMyGoalCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyGoalTableViewCell.identifier, for: indexPath) as? MyGoalTableViewCell else {
            return UITableViewCell()
        }
        
        //__ Bind the cell
        let viewModel = myGoals[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension MyGoalsDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return generateMyGoalCell(tableView, cellForRowAt: indexPath)
    }
    
}
