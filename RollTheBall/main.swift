//
//  main.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

var gameInstance = RollTheBall()

print(gameInstance.grid.description)

var x = Queue<Int>()

var y = Queue<Node>()


print(x.count)
print(x.values)
print(x.isEmpty)
print(x.dequeue())

x.enqueue(1, insertionFunc: enqueueLast)
print(x.values)

x.enqueue(3, insertionFunc: enqueueLast)
print(x.values)

x.enqueue(2, insertionFunc: enqueueLast)
print(x.values)

x.enqueue(5, insertionFunc: enqueueFirst)
print(x.values)

print(y.values)

x.dequeue()
print(x.values)