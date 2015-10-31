//
//  main.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

print("Hello, World!")
var b: Board = Board()

var x = GoalTile(location: Location(1, 2), edge: .Right)
var y = PathTile(location: (1, 2), edges: (start: .Right, end: .Left), fixed: true)

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

func makeIncrementer() -> (Int -> String) {
    func addOne(number: Int) -> String {
        return String(1 + number)
    }
    return addOne
}

var increment = makeIncrementer()
print(increment(7))

var numbers = [1, 6, 2 , 3, 4, 5]

var array: [Int] = numbers.map { number in return 3 * number }

array = array.sort { $0 > $1 }

print(array)

var z: String?
print(z)

print(array.capacity)
print(array.contains(3))
print(array.dropFirst(3))
print(array[5])
print(array.filter { number -> Bool in
    if number == 3 {
       return true
    }
    return false
    })

array.insert(7, atIndex: 0)
print(array)
print(array.capacity)

//var node: Node = Node(hValue: 1)
//var i = 0
//var s: Successor = Successor(pathCost: 1, node: Node(hValue: 1))
//node.AddSuccessor(s)
//
//s.pathCost = 2

typealias RandTile = GoalTile

var randTile = RandTile(location: (1,2), edge: .Right)

print(randTile)

//var tree = Node.generate(b.grid)
//tree.state[0][0] = InitialTile(location: (0,0), edge: .Right)
//print(b.grid == tree.state)
//
//print(b.grid.description)
//print("-----------")
//print(tree.state.description)


var x1 = [[]]
var y1 = x1
y1[0] = [1,2,3]

if x1 == y1 {
    print("Same Reference")
}else{
    print("Different Reference")
}