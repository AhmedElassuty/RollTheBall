//
//  Tile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

typealias Location = (row: Int!, col: Int!)

class Tile {
    // Instance properties
    var location: Location! = (0,0)
    var canMove = true
    var isEmpty = true

    // Initializers
    init(){}

    init(row: Int, col: Int, isEmpty: Bool = false, canMove: Bool = true){
        location = (row, col)
        self.canMove = canMove
        self.isEmpty = isEmpty
    }

    init(location: Location, isEmpty: Bool = false, canMove: Bool = true){
        self.location = location
        self.canMove = canMove
        self.isEmpty = isEmpty
    }
}

class BlankTile: Tile {}