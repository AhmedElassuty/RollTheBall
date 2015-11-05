//
//  Generic.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/3/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

var numberOfExaminedNodes: Int = 0
var numberOfExpandedNodes: Int = 0

enum Strategy: Int {
    case BF, DF, ID, GR_1, GR_2, A_Start
}

func search(grid: [[Tile]], strategy: Strategy, visualize: Bool){
    numberOfExaminedNodes = 0
    numberOfExpandedNodes = 0
    let problem = RollTheBall(grid: grid)
    let result: Node?
    switch strategy {
    case .BF:
        result = breadthFirst(problem)
    case .DF:
        result = depthFirstSearch(problem)
    case .ID:
        result = iterativeDeepening(problem)
    case .GR_1:
        result = greedySearch(problem, heuristicFunc: greedyHeuristicFunc1)
    case .GR_2:
        result = greedySearch(problem, heuristicFunc: greedyHeuristicFunc2)
    case .A_Start:
        result = aStartSearch(problem, heuristicFunc: aStarHeuristicFunc)
    }
    
    // return parameters
    
    // backtrack correct path if any
    if result != nil {
        print("--------------- Correct path backtrack ---------------")
        correctPath(problem, node: result!)
    } else {
        print("No Solution")
    }
    
    // cost
    print("--------------- Cost of the solution ---------------")
    print("Cost = \(numberOfExaminedNodes)")

    print("--------------- Number of nodes expanded ---------------")
    print("Number of Nodes expaneded \(numberOfExpandedNodes)")
}

func correctPath(problem: Problem, node: Node){
    if node.parentNode == nil {
        print("Initial Grid :")
        visualizeBoard(problem.stateSpace[node.state]!)
        return
    }
    correctPath(problem, node: node.parentNode!)
    print("Action: move node at \(node.action?.move.inverse().apply((node.action?.location)!).toString()) to \(node.action?.location.toString())")
    visualizeBoard(problem.stateSpace[node.state]!)
}

// Search Algorithms

// for search algorithms without heuristic function
private func generalSearch(problem: Problem, enqueueFunc: [Node] -> Int) -> Node? {
    let rollTheBall = problem as! RollTheBall
    // hash the initialState
    let initialStateHashValue = hashGrid(rollTheBall.initialState)

    // Add it to the stateSpace
    rollTheBall.stateSpace[initialStateHashValue] = rollTheBall.initialState

    // create initialNode for the initialState
    let initialNode: Node = Node(parentNode: nil, state: initialStateHashValue, depth: 0, pathCost: 0, hValue: nil, action: nil)
    
    // create processing queue
    let nodes = Queue<Node>(data: initialNode)
    while !nodes.isEmpty {
        let node = nodes.dequeue()
        numberOfExaminedNodes++
        if problem.goalState(node.state) {
            return node
        }
        // expand next level of the current node
        // and add the expanded nodes to the queue
        let expandedNodes = node.expand(rollTheBall)
        numberOfExpandedNodes += expandedNodes.count
        nodes.enqueue(expandedNodes, insertionFunc: enqueueFunc)
    }
    
    print("Number of states expaneded \(problem.stateSpace.count)")

    return nil
}

// for search algorithms with heuristic function
private func generalSearch(problem: Problem, evalFunc: Node -> Int, heuristicFunc: Node -> Int) -> Node? {
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
        nodes.enqueue(node.expand(problem, heuristicFunc: heuristicFunc), insertionFunc: enqueueInIncreasingOrder, evalFunc: evalFunc)
    }

    return nil
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
    return generalSearch(problem, evalFunc: evalFunc, heuristicFunc: heuristicFunc)
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

private func enqueueInIncreasingOrder<Node>(nodes: [Node], toInsert: Node, evalFunc: Node -> Int) -> Int {
    for var i = 0; i < nodes.count; i++ {
        let node = nodes[i]
        if evalFunc(node) > evalFunc(node) {
            return i
        }
    }
    return nodes.count
}