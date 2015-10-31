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
    var fixed = false
    var isEmpty = true
    var moved = false

    // Initializers
    init(){}

    init(row: Int, col: Int, isEmpty: Bool = false, fixed: Bool = false){
        location = (row, col)
        self.fixed = fixed
        self.isEmpty = isEmpty
    }

    init(location: Location, isEmpty: Bool = false, fixed: Bool = false){
        self.location = location
        self.fixed = fixed
        self.isEmpty = isEmpty
    }
    
    func getLocationForEdge(boardlimits: Location, exitEdge: Edge) -> Location? {
        var location: Location!
        switch exitEdge {
        case .Right:
            location = (self.location.row, self.location.col + 1)
        case .Left:
            location = (self.location.row, self.location.col - 1)
        case .Top:
            location = (self.location.row - 1, self.location.col)
        case .Bottom:
            location = (self.location.row + 1, self.location.col)
        }

        if location.row < 0 || location.col < 0 || location.row == boardlimits.row || location.col == boardlimits.col {
            return nil
        }

        return location
    }
}

class BlankTile: Tile {}