//
//  Tile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

typealias BlankTile = Tile

class Tile {
    // Instance properties
    var xPosition:Int! = 0
    var yPosition:Int! = 0
    var canMove = false
    var isEmpty = true

    // Initializers
    init(){}

    init(xPosition: Int, yPosition: Int, isEmpty: Bool = false, canMove: Bool = false){
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.canMove = canMove
        self.isEmpty = isEmpty
    }

    init(location: (Int, Int), isEmpty: Bool = false, canMove: Bool = false){
        xPosition = location.0
        yPosition = location.1
        self.canMove = canMove
        self.isEmpty = isEmpty
    }
}