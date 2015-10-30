//
//  Tile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

typealias Location = (row: Int!, col: Int!)

typealias BlankTile = Tile

class Tile {
    // Instance properties
    var row:Int! = 0
    var col:Int! = 0
    var canMove = false
    var isEmpty = true

    // Initializers
    init(){}

    init(row: Int, col: Int, isEmpty: Bool = false, canMove: Bool = false){
        self.row = row
        self.col = col
        self.canMove = canMove
        self.isEmpty = isEmpty
    }

    init(location: Location, isEmpty: Bool = false, canMove: Bool = false){
        row = location.row
        col = location.col
        self.canMove = canMove
        self.isEmpty = isEmpty
    }
}