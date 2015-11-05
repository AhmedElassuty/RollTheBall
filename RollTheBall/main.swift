//
//  main.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

let grid: [[Tile]] = genGrid()
search(grid, strategy: Strategy.DF, visualize: true)


//class A <T>{
//    var array: [[T]] = []
//}
//
//var test1 = A<Tile>()
//var test2 = test1
//
//test1.array.append([])
//test1.array[0].insert(PathTile(location: Location(row: 0,col: 0), config: [.Right, .Left], fixed: false), atIndex: 0)
//
//test1.array[0][0] = BlankTile(location: Location(row: 0,col: 0))
//print(test1.array)
//print(test2.array)