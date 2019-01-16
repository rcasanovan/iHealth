//
//  GoalsDatasource.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class GoalsDatasource: NSObject {
    
    public var goals: [GoalViewModel]
    
    public override init() {
        goals = []
        super.init()
    }
    
}

extension GoalsDatasource {
    
    private func generateGoalCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.identifier, for: indexPath) as? GoalTableViewCell else {
            return UITableViewCell()
        }
        
        //__ Bind the cell
        let viewModel = goals[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension GoalsDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return generateGoalCell(tableView, cellForRowAt: indexPath)
    }
    
}
