//
//  Generic.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/3/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

var numberOfExaminedNodes: Int = 0
var numberOfNodesExpanded: Int = 0
var dequeuedNodes: [Node] = []
var iterativeDeepingSubProblems: [Problem] = []

enum Strategy: Int {
    case BF, DF, ID, GR_1, GR_2, A_Start
}

func search(grid: [[Tile]], strategy: Strategy, visualize: Bool, showStep: Bool = false){
    // reset variables
    numberOfExaminedNodes = 0
    numberOfNodesExpanded = 0
    dequeuedNodes = []
    iterativeDeepingSubProblems = []

    let problem = RollTheBall(grid: grid)
    let result: Node?
    switch strategy {
    case .BF:
        result = breadthFirst(problem)
    case .DF:
        result = depthFirstSearch(problem)
    case .ID:
        result = iterativeDeepening(grid)
    case .GR_1:
        result = greedySearch(problem, heuristicFunc: greedyHeuristicFunc1)
    case .GR_2:
        result = greedySearch(problem, heuristicFunc: greedyHeuristicFunc2)
    case .A_Start:
        result = aStartSearch(problem, heuristicFunc: aStarHeuristicFunc)
    }
    
    // return parameters
    // backtrack correct path if any
    if visualize {
        if result != nil {
            print("--------------- Correct path ---------------")
            if strategy == .ID {
                correctPath(iterativeDeepingSubProblems.last!, node: result!)
            } else {
                correctPath(problem, node: result!)
            }
        }
    }
    
    if (showStep){
        if strategy == .ID {
            for subProblem in iterativeDeepingSubProblems {
                stepTrack(subProblem)
            }
        } else {
            stepTrack(problem)
        }
    }
    
    if result == nil {
        print(" No Solution")
    }
    
    // cost
    print("--------------- Cost of the solution ---------------")
    print("Cost = \(numberOfExaminedNodes)")

    print("--------------- Number of nodes chosen for expansion ---------------")
    print("Number of Nodes expaneded \(numberOfNodesExpanded)")
}

func stepTrack(problem: Problem){
    for node in dequeuedNodes {
        visualizeBoard(problem.stateSpace[node.state]!)
    }
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
    // hash the initialState
    let initialStateHashValue = hashGrid(problem.initialState)

    // create initialNode for the initialState
    let initialNode: Node = Node(parentNode: nil, state: initialStateHashValue, depth: 0, pathCost: 0, hValue: nil, action: nil)
    
    // create processing queue
    let nodes = Queue<Node>(data: initialNode)
    while !nodes.isEmpty {
        let node = nodes.dequeue()
        dequeuedNodes.append(node)
        numberOfExaminedNodes++
        if problem.goalState(node.state) {
            return node
        }
        // expand next level of the current node
        // and add the expanded nodes to the queue
        nodes.enqueue(node.expand(problem), insertionFunc: enqueueFunc)
        numberOfNodesExpanded++
    }

    return nil
}

private func breadthFirst(problem: Problem) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueLast)
}

private func depthFirstSearch(problem: Problem) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueFirst)
}

// for search algorithms with limited depth
private func generalSearch(problem: Problem, enqueueFunc: [Node] -> Int, maxDepth: Int) -> Node? {
    // hash the initialState
    let initialStateHashValue = hashGrid(problem.initialState)

    // create initialNode for the initialState
    let initialNode: Node = Node(parentNode: nil, state: initialStateHashValue, depth: 0, pathCost: 0, hValue: nil, action: nil)
    
    // create processing queue
    let nodes = Queue<Node>(data: initialNode)
    while !nodes.isEmpty {
        let node = nodes.dequeue()
        dequeuedNodes.append(node)
        numberOfExaminedNodes++
        if problem.goalState(node.state) {
            return node
        }
        // expand next level of the current node
        // and add the expanded nodes to the queue
        if node.depth != maxDepth {
            nodes.enqueue(node.expand(problem), insertionFunc: enqueueFunc)
            numberOfNodesExpanded++
        }
    }
    return nil
}

private func depthLimitedSearch(problem: Problem, depth: Int) -> Node? {
    return generalSearch(problem, enqueueFunc: enqueueFirst, maxDepth: depth)
}

private func iterativeDeepening(grid: [[Tile]]) -> Node? {
    for var depth = 0; true; depth++ {
        let problem = RollTheBall(grid: grid)
        iterativeDeepingSubProblems.append(problem)
        if let result = depthLimitedSearch(problem, depth: depth){
            return result
        }
    }
}

// for search algorithms with heuristic function
private func generalSearch(problem: Problem, evalFunc: Node -> Int, heuristicFunc: Node -> Int) -> Node? {
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