//
//  main.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

print("Hello, World!")
var b:Board!

var x = GoalTile(xPostion: 1,yPostion: 2)
var y = PathTile(xPostion: 1,yPostion: 2, start: .Right, end: Edge.Right)

var tiles = [Tile]()
tiles.append(y)
tiles.append(x)

for tile in tiles{
    if tile is GoalTile {
        print("yes")
    }else{
        print("no")
    }
}

