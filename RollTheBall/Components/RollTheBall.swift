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
        let initialTile: InitialTile = (state!.flatten().filter { $0 is InitialTile}.first)! as! InitialTile
        let compatableEdge: Edge = initialTile.exitEdge.compatableEdge()
        let nextLocation = initialTile.location.translate(initialTile.exitEdge.translationFactor())
        
        func recursive(targetLocation: Location, targetEdge: Edge) -> Bool {
            let nextTile = state![targetLocation.row][targetLocation.col]
            
            if nextTile is PathTile {
//                (nextTile as! PathTile).config
                
                return true
            }
            
            if nextTile is GoalTile {
                if (nextTile as! GoalTile).enterEdge.isCompatableWith(targetEdge) {
                    return true
                }
            }
            
            return false
        }
        
        return recursive(nextLocation, targetEdge: compatableEdge)
    }
    
    func isOutOfBounds(location: Location) -> Bool {
        if location.row < 0 || location.row >= rows || location.col < 0 || location.col >= cols {
            return true
        }
        return false
    }
}