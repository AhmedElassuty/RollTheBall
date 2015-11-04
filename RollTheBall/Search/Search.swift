//
//  Generic.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/3/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

enum Strategy: Int {
    case BF, DF, ID, GR_1, GR_2, A_Start
}

func search(grid: [[Tile]], strategy: Strategy, visualize: Bool){
    let problem = RollTheBall(grid: grid)
    switch strategy {
    case .BF:
        breadthFirst(problem)
    case .DF:
        depthFirstSearch(problem)
    case .ID:
        iterativeDeepening(problem)
    case .GR_1:
        greedySearch(problem, heuristicFunc: greedyHeuristicFunc1)
    case .GR_2:
        greedySearch(problem, heuristicFunc: greedyHeuristicFunc2)
    case .A_Start:
        aStartSearch(problem, heuristicFunc: aStarHeuristicFunc)
    }
}

// Search Algorithms
private func generalSearch(problem: Problem, enqueueFunc: [Node] -> Int) -> Node? {
    let problem = problem as! RollTheBall
    
    // hash the initialState
    let intialStateHashValue = hashGrid(problem.initialState)

    // Add it to the stateSpace
    problem.stateSpace[intialStateHashValue] = problem.initialState

    // create initialNode for the initialState
    let initialNode: Node = Node(parentNode: nil, state: intialStateHashValue, depth: 0, pathCost: nil, hValue: nil, action: nil)
    
    // create processing queue
    var nodes = Queue<Node>(data: initialNode)

    while !nodes.isEmpty {
        let node = nodes.dequeue()
        if problem.goalState(node.state) {
            return node
        }
        // expand next level of the current node
        // and add the expanded nodes to the queue
        nodes.enqueue(node.expand(problem), insertionFunc: enqueueFunc)
    }

    return nil
}

private func generalSearch(problem: Problem, enqueueFunc: ([Node], Node, Node -> Int) -> Int, heuristicFunc: Node -> Int) -> Node? {
    _ = Queue<Node>()
    return Node()
}

private func breadthFirst(problem: Problem) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueLast)
}

private func depthFirstSearch(problem: Problem) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueFirst)
}

private func depthLimitedSearch(problem: Problem, depth: Int) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueFirst)
}

private func iterativeDeepening(problem: Problem) -> Node? {
    for var depth = 0; true; depth++ {
        if let result = depthLimitedSearch(problem, depth: depth){
            return result
        }
    }
}

private func bestFirstSearch(problem: Problem, evalFunc: Node -> Int, heuristicFunc: Node -> Int) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueInIncreasingOrder, heuristicFunc: heuristicFunc)
}

private func greedySearch(problem: Problem, heuristicFunc: (Node) -> Int) -> Node? {
    func greedyEvalFunc(node: Node) -> Int {
        return node.hValue!
    }

    return bestFirstSearch(problem, evalFunc: greedyEvalFunc, heuristicFunc: heuristicFunc)
}

private func aStartSearch(problem: Problem, heuristicFunc: (Node) -> Int) -> Node? {
    func A_StarEvalFunc(node: Node) -> Int {
        return node.hValue! + node.pathCost!
    }

    return bestFirstSearch(problem, evalFunc: A_StarEvalFunc, heuristicFunc: heuristicFunc)
}

// Heuristic Functions
func greedyHeuristicFunc1(node: Node) -> Int {
    return 0
}

func greedyHeuristicFunc2(node: Node) -> Int {
    return 0
}

func aStarHeuristicFunc(node: Node) -> Int {
    return greedyHeuristicFunc1(node)
}

// Queue configurations
private func enqueueLast<Node>(input: [Node]) -> Int {
    return input.count
}

private func enqueueFirst<Node>(input: [Node]) -> Int{
    return 0
}

private func enqueueInIncreasingOrder(nodes: [Node], toBeInserted: Node, evalFunc: Node -> Int) -> Int {
    for var i = 0; i < nodes.count; i++ {
        let node = nodes[i]
        if evalFunc(node) > evalFunc(node) {
            return i
        }
    }
    return nodes.count
}