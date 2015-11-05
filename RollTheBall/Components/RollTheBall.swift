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
        operators = Operator.getAll()
        rows = grid.count
        cols = grid[0].count
    }

    // Methods
    override func goalState(stateHashValue: String) -> Bool {
        let state = stateSpace[stateHashValue]
        let initialTile: InitialTile = (state!.flatten().filter { $0 is InitialTile}.first)! as! InitialTile
        let compatableEdge: Edge = initialTile.exitEdge.compatableEdge()
        let nextLocation = initialTile.location.translate(initialTile.exitEdge.translationFactor())

        func recursiveGoalTest(targetLocation: Location, targetEdge: Edge) -> Bool {
            if targetLocation.withInRange(rows, col: cols) {
                let nextTile = state![targetLocation.row][targetLocation.col]
                
                if nextTile is PathTile {
                    let pathTile = (nextTile as! PathTile)
                    if pathTile.config.contains(targetEdge){
                        let exitEdge = pathTile.config.filter { $0 != targetEdge }.first
                        let location = pathTile.location.translate(exitEdge!.translationFactor())
                        return recursiveGoalTest(location, targetEdge: (exitEdge?.compatableEdge())!)
                    }
                    // not compatable path tile
                    return false
                }
                
                if nextTile is GoalTile && (nextTile as! GoalTile).enterEdge == targetEdge {
                    return true
                }
            }
            
            // any other tile
            // or out of board bounds
            return false
        }
        
        
        return recursiveGoalTest(nextLocation, targetEdge: compatableEdge)
    }
    

    
    func isOutOfBounds(location: Location) -> Bool {
        if location.row < 0 || location.row >= rows || location.col < 0 || location.col >= cols {
            return true
        }
        return false
    }
}