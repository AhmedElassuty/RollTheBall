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

    // Methods
//    func genGrid(){
//        initDimensions()
//        initGrid()
//        initBasicTiles()
//        initCorrectPath()
//    }
//
//    func initDimensions(){
//        rows = (MIN_ROWS...MAX_ROWS).randomInt
//        cols = (MIN_COLS...MAX_COLS).randomInt
//    }
//
//    func initGrid(){
//        for row in 0...(rows - 1) {
//            grid.append([])
//            for col in 0...(cols - 1) {
//                grid[row].append(Tile(location: Location(row: row, col: col), isEmpty: true))
//            }
//        }
//    }
//    
//    func initBasicTiles(){
//        func configurations() -> (vacantLocation: Location, edge: Edge){
//            let vacantLocation =  getVacantLocation()
//            let validEdges = getValidEdges(vacantLocation, fixed: true)
//            let edge = Edge.random(validEdges)
//            return (vacantLocation, edge)
//        }
//
//        var conf = configurations()
//        grid[conf.vacantLocation.row][conf.vacantLocation.col] = GoalTile(location: conf.vacantLocation, edge: conf.edge)
//        
//        conf = configurations()
//        grid[conf.vacantLocation.row][conf.vacantLocation.col] = InitialTile(location: conf.vacantLocation, edge: conf.edge)
//    }
//    
//    func initCorrectPath(){
//        
//    }
//
//    func getVacantLocation() -> Location {
//        let vacantLocations = grid.reduce([Location](), combine: {
//            (var result: [Location], tiles: [Tile]) -> [Location] in
//            tiles.forEach {
//                if $0.isEmpty {
//                    result.append($0.location)
//                }
//            }
//            return result
//        })
//
//        let randIndex = Int.random(vacantLocations.count)
//        let vacantLocation = vacantLocations[randIndex]
//        return vacantLocation
//    }
//    
//    func getValidEdges(location: Location, fixed: Bool) -> [Edge] {
//        var validEdges: [Int: Edge] = [ Edge.Left.rawValue: .Left, Edge.Right.rawValue: .Right
//            , Edge.Top.rawValue: .Top, Edge.Bottom.rawValue: .Bottom]
//        
//        func checkNearByTiles(targetLocation: Location, edge: Edge) {
//            if !isOutOfBounds(targetLocation) {
//                let tile = getTileAtLocation(targetLocation)
//                if !tile.isEmpty && tile.fixed {
//                    if tile is GoalTile {
//                        let goalTile = tile as! GoalTile
//                        if !goalTile.enterEdge.isCompatableWith(edge) {
//                            validEdges.removeValueForKey(edge.rawValue)
//                        }
//                    } else if tile is PathTile {
//                        let pathTile = tile as! PathTile
//                        if !pathTile.hasCompatableEdgeWith(.Top) {
//                            validEdges.removeValueForKey(edge.rawValue)
//                        }
//                    }
//                }
//            }
//        }
//
//        if fixed {
//            // bottom edge
//            if location.row == (rows - 1) {
//                validEdges.removeValueForKey(Edge.Bottom.rawValue)
//            }
//
//            // top edge
//            if location.row == 0 {
//                validEdges.removeValueForKey(Edge.Top.rawValue)
//            }
//            
//            // right edge
//            if location.col == (cols - 1) {
//                validEdges.removeValueForKey(Edge.Right.rawValue)
//            }
//            
//            // left edge
//            if location.col == 0 {
//                validEdges.removeValueForKey(Edge.Left.rawValue)
//            }
//        }
//            // check the top edge tile
//            var targetLocation = Location(row: location.row - 1, col: location.col)
//            checkNearByTiles(targetLocation, edge: .Top)
//
//            // check the bottom edge tile
//            targetLocation = Location(row: location.row + 1, col: location.col)
//            checkNearByTiles(targetLocation, edge: .Bottom)
//            
//            // check the right edge tile
//            targetLocation = Location(row: location.row, col: location.col + 1)
//            checkNearByTiles(targetLocation, edge: .Right)
//
//            // check the left edge tile
//            targetLocation = Location(row: location.row, col: location.col - 1)
//            checkNearByTiles(targetLocation, edge: .Left)
//            
//            // check if we can put a fixed tile at the provided location
//            if validEdges.isEmpty {
//                
//            }
////        }
//
//        return validEdges.values.reduce([Edge](), combine: {
//            (var result: [Edge], edge: Edge) -> [Edge] in
//            result.append(edge)
//            return result
//        })
//    }
//