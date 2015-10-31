//
//  BasicTile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/29/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class GoalTile: Tile {
    var opening: Edge!
    
    override init(row: Int, col: Int, isEmpty: Bool = false, canMove: Bool = false) {
        super.init(row: row, col: col)
    }
    
    init(location: Location, edge: Edge){
        super.init(location: location)
        opening = edge
    }
}

class InitialTile: Tile {
    var opening: Edge!
    
    override init(row: Int, col: Int, isEmpty: Bool = false, canMove: Bool = false) {
        super.init(row: row, col: col)
    }
    
    init(location: Location, edge: Edge){
        super.init(location: location)
        opening = edge
    }
}