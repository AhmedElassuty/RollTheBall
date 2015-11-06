//
//  Node.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

// Node class
// constructs the 5 tuple of search tree node
class Node {
    // refrences to the parent node
    var parentNode: Node?
    // String refrences the related state from the problem state space
    var state: String!
    // depth of the node
    var depth:Int!
    // path cost from the initial node
    var pathCost: Int?
    // the action performed to generate the node
    var action: Action?
    
    // Heuristic value for A* and Greedy
    var hValue: Int?
    
    // Initializers
    init(parentNode: Node?, state: String!, depth: Int!, pathCost: Int?, hValue: Int?, action: Action?){
        self.parentNode = parentNode
        self.state = state
        self.depth = depth
        self.pathCost = pathCost
        self.action = action

        self.hValue = hValue
    }
    
    // functions

    // Expand the node
    // - targets all blank tiles that can be swaped with movable tiles
    // - ignores the tile moved by the parent node and indicated by the node action
    // - adds the expanded nodes to the state space
    // - ignores repeated states to eliminate infinite loops
    // returns array of all non-repeated accessible states from the parent node
    func expand(problem: Problem) -> [Node]{
        var expandedNodes: [Node] = []
        let problem = problem as! RollTheBall
        let maxRows = problem.rows
        let maxCols = problem.cols
        
        // current parent state
        let parentState = problem.stateSpace[self.state]
        let oldAction: Action? = self.action

        for var row = 0; row < maxRows; row++ {
            for var col = 0; col < maxCols; col++ {
                // target only blank tiles
                let tile = parentState![row][col]
                if tile is BlankTile {
                    // Apply all given operators
                    let oldLocation = tile.location
                    
                    for action in problem.operators {
                        let newLocation: Location = action.apply(tile.location)
                        
                        if oldAction != nil && oldAction!.location.equal(newLocation) && action == oldAction!.move {
                            continue
                        }

                        // Apply the current action to
                        // the location of the current blank tile
                        
                        
                        // New location is out of board boundries
                        if !newLocation.withInRange(maxRows, col: maxCols) {
                            continue
                        }

                        // Tile at the new Location cannot move
                        let tileToSwapWith: Tile = parentState![newLocation.row][newLocation.col]

                        if tileToSwapWith.fixed || tileToSwapWith is BlankTile {
                            continue
                        }

                        // create new state
                        var newState = parentState!
                        
                        // apply the current action by changing
                        // the targeted tile location in the new state
                        
//                        visualizeBoard(parentState!)

                        switch tileToSwapWith {
                        case is BlockTile:
                            newState[row][col] = BlockTile(location: tile.location)
                        case is PathTile:
                            newState[row][col] = PathTile(location: tile.location, config: (tileToSwapWith as! PathTile).config, fixed: false)
                        default:
                            break
                        }
                        
                        newState[newLocation.row][newLocation.col] = BlankTile(location: newLocation)

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
                        let newNode = Node(parentNode: self, state: hashValue, depth: self.depth + 1, pathCost: self.pathCost! + 1, hValue: nil, action: Action(location: oldLocation, move: action.inverse()))

                        // add the generated state to the result array
                        expandedNodes.append(newNode)
                    }
                }
            }
        }
        return expandedNodes
    }
    
    
    // expand subnodes and calculate its heuristic values
    func expand(problem: Problem, heuristicFunc: [[Tile]] -> Int) -> [Node]{
        var expandedNodes: [Node] = []
        let problem = problem as! RollTheBall
        let maxRows = problem.rows
        let maxCols = problem.cols
        
        // current parent state
        let parentState = problem.stateSpace[self.state]
        let oldAction: Action? = self.action
        
        for var row = 0; row < maxRows; row++ {
            for var col = 0; col < maxCols; col++ {
                // target only blank tiles
                let tile = parentState![row][col]
                if tile is BlankTile {
                    // Apply all given operators
                    let oldLocation = tile.location
                    
                    for action in problem.operators {
                        let newLocation: Location = action.apply(tile.location)
                        
                        if oldAction != nil && oldAction!.location.equal(newLocation) && action == oldAction!.move {
                            continue
                        }
                        
                        // Apply the current action to
                        // the location of the current blank tile
                        
                        
                        // New location is out of board boundries
                        if !newLocation.withInRange(maxRows, col: maxCols) {
                            continue
                        }
                        
                        // Tile at the new Location cannot move
                        let tileToSwapWith: Tile = parentState![newLocation.row][newLocation.col]
                        
                        if tileToSwapWith.fixed || tileToSwapWith is BlankTile {
                            continue
                        }
                        
                        // create new state
                        var newState = parentState!
                        
                        // apply the current action by changing
                        // the targeted tile location in the new state

                        switch tileToSwapWith {
                        case is BlockTile:
                            newState[row][col] = BlockTile(location: tile.location)
                        case is PathTile:
                            newState[row][col] = PathTile(location: tile.location, config: (tileToSwapWith as! PathTile).config, fixed: false)
                        default:
                            break
                        }
                        
                        newState[newLocation.row][newLocation.col] = BlankTile(location: newLocation)
                        
                        // hash the new state
                        let hashValue = hashGrid(newState)
                        
                        // Check the uniquness of the created state
                        // to prevent infinite expansion
                        if let _ = problem.stateSpace[hashValue] {
                            continue
                        }
                        
                        // add the new state to the state space of the problem
                        problem.stateSpace[hashValue] = newState
                        
                        // calculate the heuristic value
                        let heuristicValue = heuristicFunc(newState)

                        // create new node
                        let newNode = Node(parentNode: self, state: hashValue, depth: self.depth + 1, pathCost: self.pathCost! + 1, hValue: heuristicValue, action: Action(location: oldLocation, move: action.inverse()))
                        
                        // add the generated state to the result array
                        expandedNodes.append(newNode)
                    }
                }
            }
        }
        return expandedNodes
    }
}