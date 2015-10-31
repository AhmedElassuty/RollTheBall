//
//  Node.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Node {
    // Instance properties
    var parentNode: Node?
    var state: [[Tile]]!
    var successors: [Node]
    var depth:Int!
    var pathCost: Int?
    var hValue: [Int]?
    var location: Location
    
    // Not instance
    var tile : Tile {
        return state[location.row][location.col]
    }
    
    var exitEdge: Edge {
        if tile is InitialTile {
            return (tile as! InitialTile).exitEdge
        }else{
            return (tile as! PathTile).end
        }
    }
    
    // Initializers
    init(parentNode: Node?, state: [[Tile]]!, depth: Int!, pathCost: Int?, hValue: [Int]?, location: Location){
        self.parentNode = parentNode
        self.state = state
        self.depth = depth
        self.pathCost = pathCost
        self.hValue = hValue
        self.location = location
        successors = [Node]()
        
        var parentExitEdge: Edge!
        if parentNode?.tile is InitialTile{
            parentExitEdge = (parentNode?.tile as! InitialTile).exitEdge
        }else{
            parentExitEdge = (parentNode?.tile as! PathTile).end
        }
        if tile is PathTile {
            let pathTile = (tile as! PathTile)
            if parentExitEdge.compatableEdge() == pathTile.end {
                pathTile.end   = pathTile.start
                pathTile.start = parentExitEdge.compatableEdge()
                
            }
        }
    }
    
    // Methods
    func leaf() -> Bool{
        return successors.isEmpty
    }
    
    func addSuccessor(successor: Node){
        successors.append(successor)
    }
    
    static func generate(board: Board) -> Node {
        let initialTile = board.grid.flatten().filter {
            $0 is InitialTile
            }.first! as! InitialTile
        let initialNode = Node(parentNode: nil, state: board.grid, depth: 0, pathCost: nil, hValue: nil, location: initialTile.location)
        initialNode.recursive()
        
        return initialNode
    }

    func recursive(){
        let targetLocation = tile.getLocationForEdge((state.count, state.first!.count), exitEdge: exitEdge)
        let compatableEdge = exitEdge.compatableEdge()
        // Faces Board Border
        if targetLocation == nil {
            return
        }
        
        var newState = state
        newState[location.row][location.col].moved = true
        
        // Faces Goal Tile
        let currentTargetTile = state[targetLocation!.row][targetLocation!.col]
        if currentTargetTile is GoalTile {
            let goalTile = currentTargetTile as! GoalTile
            if goalTile.enterEdge == compatableEdge {
                let goalNode = Node(parentNode: self, state: newState, depth: depth + 1, pathCost: 1, hValue: nil, location: targetLocation!)
                addSuccessor(goalNode)
            }
            return
        }
        
        // Faces Fixed PathTile OR Moved
        if currentTargetTile is PathTile {
            let pathTile = currentTargetTile as! PathTile

            if pathTile.moved {
                return
            } else if pathTile.fixed {
                if compatableEdge == pathTile.end || compatableEdge == pathTile.start {
                    let newNode = Node(parentNode: self, state: newState, depth: depth + 1, pathCost: 1, hValue: nil, location: pathTile.location)
                    addSuccessor(newNode)
                    newNode.recursive()
                    return
                }else{
                    print("not Compatable")
                    return
                }
            }
        }
        
        let pathtiles = newState.flatten().filter { !$0.moved && ($0 is PathTile) && !$0.fixed} as! [PathTile]
        let compatiblePathTiles = pathtiles.filter {compatableEdge == $0.end || compatableEdge == $0.start}
        
        for compatibleTile in compatiblePathTiles {
            let swapValue = Node.swapToTargetLocation(targetLocation!, compatibleTileLocation: compatibleTile.location,state: newState)
            let newPathCost = swapValue.pathCost // calculate The Path cost and change new state
            if newPathCost > 0 {
                let newNode = Node(parentNode: self, state: swapValue.newState, depth: depth + 1, pathCost: 1, hValue: nil, location: targetLocation!)
                addSuccessor(newNode)
                newNode.recursive()
            }
            
        }
    }
    
    static func swapToTargetLocation(targetLocation: Location, compatibleTileLocation: Location, state: [[Tile]]) -> (pathCost: Int, newState: [[Tile]]){
        let newState = state
        let newPathCost = 0
        // Swap Logic Recursive
            // Bring the blank next to the compatible tile
        
        
        
        return (pathCost: newPathCost, newState: newState)
    }
    
    
    
    
}