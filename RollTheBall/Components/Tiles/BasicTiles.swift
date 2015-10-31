//
//  BasicTile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/29/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class GoalTile: Tile {
    var enterEdge: Edge!

    init(location: Location, edge: Edge){
        super.init(location: location, fixed: true)
        enterEdge = edge
    }
}

class InitialTile: Tile {
    var exitEdge: Edge!

    init(location: Location, edge: Edge){
        super.init(location: location, fixed: true)
        exitEdge = edge
    }
}