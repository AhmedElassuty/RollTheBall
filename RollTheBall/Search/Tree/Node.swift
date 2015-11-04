//
//  Node.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Node {
    // Basic 5 search node properties
    var parentNode: Node?
    var state: String!
    var depth:Int!
    var pathCost: Int?
    var action: Action?
    
    // Heuristic value for A* and Greedy
    var hValue: Int?
    
    // Initializers
    init(){}

    init(parentNode: Node?, state: String!, depth: Int!, pathCost: Int?, hValue: Int?, action: Action?){
        self.parentNode = parentNode
        self.state = state
        self.depth = depth
        self.pathCost = pathCost
        self.action = action

        self.hValue = hValue
    }
    
    // functions
    func expand(problem: Problem) -> [Node]{
        var expandedNodes: [Node] = []
        let problem = problem as! RollTheBall
        let maxRows = problem.rows
        let maxCols = problem.cols
        
        // current parent state
        let parentState = problem.stateSpace[self.state]

        for var row = 0; row < maxRows; row++ {
            for var col = 0; col < maxCols; col++ {
                // target only blank tiles
                let tile = parentState![row][col]
                if tile is BlankTile {
                    // Apply all given operators
                    let oldAction: Action = self.action!
                    for action in problem.operators {
                        if oldAction.location.equal(tile.location) && action.isInverseOf(oldAction.move){
                            continue
                        }

                        // Apply the current action to
                        // the location of the current blank tile
                        let newLocation: Location = action.apply(tile.location)
                        
                        // New location is out of board boundries
                        if newLocation.row < 0 || newLocation.row >= maxRows || newLocation.col < 0 || newLocation.col >= maxCols {
                            continue
                        }

                        // Tile at the new Location cannot move
                        let newTile = parentState![newLocation.row][newLocation.col]
                        if newTile.fixed || newTile is BlankTile {
                            continue
                        }

                        // create new state
                        var newState: [[Tile]] = parentState!
                        
                        // apply the action by swapping the tiles
                        let tileToSwapWith = parentState![newLocation.row][newLocation.col]
                        newState[tile.location.row][tile.location.col] = tileToSwapWith
                        tile.location = newLocation
                        newState[newLocation.row][newLocation.col] = tile
                        
                        // hash the new state
                        let hashValue = hashGrid(newState)
                        
                        // Check the uniquness of the created state
                        // to prevent infinite expansion
                        if let _ = problem.stateSpace[hashValue] {
                            continue
                        }
                        
                        // add the new state to the state space of the problem
                        problem.stateSpace[hashValue] = newState

                        // create new node
                        let newNode = Node(parentNode: self, state: hashValue, depth: self.depth + 1, pathCost: self.pathCost! + 1, hValue: nil, action: Action(location: newLocation, move: action))

                        expandedNodes.append(newNode)
                    }
                }
            }
        }
        return expandedNodes
    }
    
    func expand(problem: Problem, heuristicFunc: Node -> Int) -> [Node]{
        return [Node]()
    }
}