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

typealias BlankTile = Tile

class Tile {
    // Instance properties
    var xPostion:Int! = 0
    var yPostion:Int! = 0
    var canMove = false
    
    // Initializers
    init(){}

    init(xPostion: Int, yPostion: Int){
        self.xPostion = xPostion
        self.yPostion = yPostion
    }

}