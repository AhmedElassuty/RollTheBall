//
//  main.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

print("Hello, World!")

var x = GoalTile()
var y = PathTile()
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

