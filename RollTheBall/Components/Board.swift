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
    }

    func initDimensions(){
        rows = (MIN_ROWS...MAX_ROWS).randomInt
        cols = (MIN_COLS...MAX_COLS).randomInt
    }

    func initGrid(){
        for row in 0...(rows - 1) {
            grid.append([])
            for _ in 1...cols {
                grid[row].append(Tile())
            }
        }
    }
    
}