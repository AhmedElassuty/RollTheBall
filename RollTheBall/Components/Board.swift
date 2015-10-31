//
//  Board.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Board {
    // Instance properties    
    var rows:Int!
    var cols:Int!
    var grid = [[Tile]]()
    
    // Initializers
    init(){
        genGrid()
    }
    
    // Methods
    func genGrid(){
        initDimensions()
        initGrid()
        initBasicTiles()
        initCorrectPath()
    }

    func initDimensions(){
        rows = (MIN_ROWS...MAX_ROWS).randomInt
        cols = (MIN_COLS...MAX_COLS).randomInt
    }

    func initGrid(){
        for row in 0...(rows - 1) {
            grid.append([])
            for col in 0...(cols - 1) {
                grid[row].append(Tile(location: (row, col), isEmpty: true))
            }
        }
    }
    
    func initBasicTiles(){
        func configurations() -> (vacantLocation: Location, edge: Edge){
            let vacantLocation =  getVacantLocation()
            let validEdges = getValidEdges(vacantLocation, fixed: true)
//            print(validEdges)
            let edge = Edge.random(validEdges)
            return (vacantLocation, edge)
        }

        var conf = configurations()
//        print(conf)
        grid[conf.vacantLocation.row][conf.vacantLocation.col] = GoalTile(location: conf.vacantLocation, edge: conf.edge)
        
        conf = configurations()
//        print(conf)
        grid[conf.vacantLocation.row][conf.vacantLocation.col] = InitialTile(location: conf.vacantLocation, edge: conf.edge)
        
    }
    
    func initCorrectPath(){
        
    }

    func getVacantLocation() -> Location {
        let vacantLocations = grid.reduce([Location](), combine: {
            (var result: [Location], tiles: [Tile]) -> [Location] in
            tiles.forEach {
                if $0.isEmpty {
                    result.append($0.location)
                }
            }
            return result
        })

        let randIndex = Int.random(vacantLocations.count)
        let vacantLocation = vacantLocations[randIndex]
        return vacantLocation
    }
    
    func getValidEdges(location: Location, fixed: Bool) -> [Edge] {
        var validEdges: [Int: Edge] = [ Edge.Left.rawValue: .Left, Edge.Right.rawValue: .Right
            , Edge.Top.rawValue: .Top, Edge.Bottom.rawValue: .Bottom]

        if fixed {
            if location.row == (rows - 1) {
                validEdges.removeValueForKey(Edge.Bottom.rawValue)
            }

            if location.row == 0 {
                validEdges.removeValueForKey(Edge.Top.rawValue)
            }
            
            if location.col == (cols - 1) {
                validEdges.removeValueForKey(Edge.Right.rawValue)
            }
            
            if location.col == 0 {
                validEdges.removeValueForKey(Edge.Left.rawValue)
            }
        }

        return validEdges.values.reduce([Edge](), combine: {
            (var result: [Edge], edge: Edge) -> [Edge] in
            result.append(edge)
            return result
        })
    }
    
    func getTileAtLocation(location: Location) -> Tile {
        return grid[location.row][location.col]
    }

}