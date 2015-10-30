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

    }
    
    func getValidLocation() -> (row: Int, col: Int) {
        var validLocations = grid.flatten().filter {
            (tile: Tile) -> Bool in
            if tile.isEmpty {
                return true
            }
            return false
        }
        let randIndex = Int(arc4random_uniform(UInt32(validLocations.count)))
        let validLocation = validLocations[randIndex]
        return (validLocation.xPosition, validLocation.yPosition)
    }

}