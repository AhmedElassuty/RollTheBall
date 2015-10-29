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

func makeIncrementer() -> (Int ->String) {
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

var node: Node = Node(hValue: 1)
var i = 0
var s: Successor = Successor(pathCost: 1, node: Node(hValue: 1))
node.AddSuccessor(s)

s.pathCost = 2

print(node.successors[0].pathCost)
print(s.pathCost)