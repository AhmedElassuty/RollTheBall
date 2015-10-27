//
//  Tile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

enum Edge {
    case Right, Left, Top, Bottom
}

class Tile {
    var xPostion:Int!
    var yPostion:Int!
    var canMove: Bool = false
    
    init(xPostion: Int, yPostion: Int){
        self.xPostion = xPostion
        self.yPostion = yPostion
    }
    
}

class GoalTile : Tile {
    var opening: Edge!
}

class InitialTile : Tile {
    var opening: Edge!
}

class Blank : Tile {}
