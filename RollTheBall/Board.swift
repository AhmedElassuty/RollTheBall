//
//  Board.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Board {
    var m:Int!
    var n:Int!
    var tiles = [[Tile]]()
    
    init(m:Int, n:Int){
        self.m = m
        self.n = n
        generateRandomTiles()
    }
    
    func generateRandomTiles() -> Void {
        
    }
}

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

class PathTile : Tile {
    
    var start: Edge!
    var end  : Edge!
    
    init(xPostion: Int, yPostion: Int, start:Edge, end: Edge) {
        super.init(xPostion: xPostion, yPostion: xPostion)
        
        if start == end {
            print("ERROR: Cannot start and End at the same Edge")
        }
        self.end = end
        self.start = start
    }
}

class GoalTile : Tile {
    
    var opening: Edge!
    
}

class InitialTile : Tile {
    
    var opening: Edge!
    
}

class BlockTile : Tile {
    
}

class Blank : Tile {
    
}

class Ball {
    
}


