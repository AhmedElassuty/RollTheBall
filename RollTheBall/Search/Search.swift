//
//  Generic.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/3/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation


enum Strategy: Int {
    case BF, GR_1, GR_2, DF, ID, A_Start
}

func search(grid: [[Tile]], strategy: Strategy, visualize: Bool){

}

func generalSearch(problem: Problem, enqueueFunc: [Node] -> Int) -> Node? {
    
    let initialNode: Node = Node(parentNode: nil, state: problem.initialState, depth: 0, pathCost: nil, hValue: nil, action: nil)
    var nodes = Queue<Node>(data: initialNode)
    while !nodes.isEmpty {
        let node = nodes.dequeue()
        if RollTheBall.goalState(node.state) {
            return node
        }
        // expand next level and add it to the nodes queue
        let expandedNodes: [Node] = node.expand()
        nodes.enqueue(expandedNodes, insertionFunc: enqueueFunc)
    }
    return nil
}

func generalSearch(problem: Problem, enqueueFunc: ([Node], Node, Node -> Int) -> Int, heuristicFunc: Node -> Int) -> Node? {
    _ = Queue<Node>()
    return Node()
}

func enqueueLast<Node>(input: [Node]) -> Int {
    return input.count
}

func breadthFirst(problem: Problem) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueLast)
}

func enqueueFirst<Node>(input: [Node]) -> Int{
    return 0
}

func depthFirstSearch(problem: Problem) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueFirst)
}

func depthLimitedSearch(problem: Problem, depth: Int) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueFirst)
}

func iterativeDeepening(problem: Problem) -> Node? {
    for var depth = 0; true; depth++ {
        if let result = depthLimitedSearch(problem, depth: depth){
            return result
        }
    }
}

// -----------------------------------------------------------------------
func enqueueInIncreasingOrder(nodes: [Node], toBeInserted: Node, evalFunc: Node -> Int) -> Int {
    for var i = 0; i < nodes.count; i++ {
        let node = nodes[i]
        if evalFunc(node) > evalFunc(node) {
            return i
        }
    }
    return nodes.count
}

func bestFirstSearch(problem: Problem, evalFunc: Node -> Int, heuristicFunc: Node -> Int) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueInIncreasingOrder, heuristicFunc: heuristicFunc)
}

func greedyHeuristicFunc1(node: Node) -> Int {
    return 0
}

func greedyHeuristicFunc2(node: Node) -> Int {
    return 0
}

func greedySearch(problem: Problem, heuristicFunc: (Node) -> Int) -> Node? {
    func greedyEvalFunc(node: Node) -> Int {
        return node.hValue!
    }

    return bestFirstSearch(problem, evalFunc: greedyEvalFunc, heuristicFunc: heuristicFunc)
}


func aStartSearch(problem: Problem) -> Node? {
    func A_StarEvalFunc(node: Node) -> Int {
        return node.hValue! + node.pathCost!
    }
    
    func aStarHeuristicFunc(node: Node) -> Int {
        return 0
    }
    
    return bestFirstSearch(problem, evalFunc: A_StarEvalFunc, heuristicFunc: aStarHeuristicFunc)
}