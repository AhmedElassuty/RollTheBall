//
//  Board.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

// should inherit from problem
class RollTheBall: Problem {
    // Instance properties    
    var rows:Int!
    var cols:Int!
    
    // Initializers
    override init(grid: [[Tile]]){
        super.init(grid: grid)
        rows = grid.count
        cols = grid[0].count
    }

    // Methods
    override func goalState(stateHashValue: String) -> Bool {
        var state = stateSpace[stateHashValue]
        return true
    }
    
    func isOutOfBounds(location: Location) -> Bool {
        if location.row < 0 || location.row >= rows || location.col < 0 || location.col >= cols {
            return true
        }
        return false
    }
}