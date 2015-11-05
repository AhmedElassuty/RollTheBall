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
    let pathsWalked =  movedPathLocations(grid)
    let previousTile: Tile? = pathsWalked.count > 1 ? grid[pathsWalked[1].row][pathsWalked[1].col] : nil
    let targetLocaion = nextLocation(grid[pathsWalked[0].row][pathsWalked[0].col], previousTile: previousTile, boardLimits: Location(row: grid.count, col: grid[0].count))
    return pathToGoal(grid, targetLocation: targetLocaion, pathLocations: pathsWalked)
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

// heuristic Function 1

func pathToGoal(grid: [[Tile]], targetLocation: Location?, pathLocations: [Location]) -> Int{

    if targetLocation == nil {
        return grid.count * grid[0].count
    }
    
    let currentTile = grid[targetLocation!.row][targetLocation!.col]
    if currentTile is GoalTile {
        return 0
    }
    
    
//    let previousTile: Tile? = pathLocations.count > 1 ?  grid[pathLocations[1].row][pathLocations[1].col] : nil
//    let goalTile = grid.flatten().filter {$0 is GoalTile }.first
    
    var newPathLocations = pathLocations
    newPathLocations.append(targetLocation!)

    var costsToGoal: [Int] = []
    
    let topLocation: Location? = (targetLocation!.row - 1) >= 0 && !pathLocations.contains {$0.row == targetLocation!.row - 1 && $0.col == targetLocation!.col } ? Location(row: targetLocation!.row - 1, col: targetLocation!.col) : nil
    let bottomLocation: Location? = (targetLocation!.row + 1) < grid.count && !pathLocations.contains {$0.row == targetLocation!.row + 1 && $0.col == targetLocation!.col } ? Location(row: targetLocation!.row + 1, col: targetLocation!.col) : nil
    let leftLocation: Location? = (targetLocation!.col - 1) >= 0 && !pathLocations.contains {$0.row == targetLocation!.col - 1 && $0.row == targetLocation!.row } ? Location(row: targetLocation!.row, col: targetLocation!.col-1) : nil
    let rightLocation: Location? = (targetLocation!.col + 1) < grid[0].count && !pathLocations.contains {$0.row == targetLocation!.col + 1 && $0.row == targetLocation!.row } ? Location(row: targetLocation!.row, col: targetLocation!.col+1) : nil
    
    
    for loc in [topLocation,bottomLocation, leftLocation, rightLocation ] {
        costsToGoal.append(pathToGoal(grid, targetLocation: loc, pathLocations: newPathLocations))
    }
    
    var leastCost = costsToGoal.first ?? grid.count * grid[0].count
    
    for cost in costsToGoal {
        if cost < leastCost {
            leastCost = cost
        }
    }
    return leastCost
    
}

func movedPathLocations(grid: [[Tile]]) -> [Location] {
    let dimensions = Location(row: grid.count, col: grid[0].count)
    let initialTile = grid.flatten().filter {$0 is InitialTile }.first
    var locations: [Location]! = [initialTile!.location]
    
    while let location = nextLocation(grid[locations.first!.row][locations.first!.col], previousTile: (locations.count > 1 ? grid[locations[1].row][locations[1].col] : nil), boardLimits: dimensions ) {
        let newLocationTile = grid[location.row][location.col]

        if compatibleEdges(grid[locations.first!.row][locations.first!.col], targetTile: newLocationTile).compatible {
            locations.append(location)
        }else{
            break
        }
    }
    return locations
}

func nextLocation(tile: Tile, previousTile: Tile?, boardLimits: Location) -> Location?{
    var exitEdge:Edge!
    switch tile {
    case is PathTile:
        for currentEdge in (tile as! PathTile).config {
            for previousEdge in ((previousTile as? PathTile)?.config ?? [(previousTile as! InitialTile).exitEdge] )! {
                if !previousEdge.isCompatableWith(currentEdge){
                    exitEdge = currentEdge
                }
            }
        }
    case is InitialTile:
        exitEdge = (tile as! InitialTile).exitEdge
        break
    default:
        return Location(row: -1, col: -1)
    }
    return tile.getLocationForEdge(boardLimits, exitEdge: exitEdge)
}

func compatibleEdges(previousTile: Tile, targetTile: Tile) -> (previousExit: Edge?, targetEnterEdge: Edge?, compatible: Bool){
    var exitEdge : Edge?
    var enterEdge: Edge?
    var areCompatible: Bool = false
    var previousTileConfig = [Edge]()
    var targetTileConfig = [Edge]()

    switch previousTile {
    case is InitialTile:
        previousTileConfig.append((previousTile as! InitialTile).exitEdge)
    case is PathTile:
        previousTileConfig.appendContentsOf((previousTile as! PathTile).config)
    default:
        break
    }
    
    switch targetTile {
    case is GoalTile:
       targetTileConfig.append((targetTile as! GoalTile).enterEdge)
    case is PathTile:
        targetTileConfig.appendContentsOf((targetTile as! PathTile).config)
    default:
        break
    }
    
    for previousEdge in previousTileConfig {
        for targetEdge in targetTileConfig {
            if previousEdge.isCompatableWith(targetEdge) {
                exitEdge      = previousEdge
                enterEdge     = targetEdge
                areCompatible = true
            }
        }
    }
    exitEdge  = exitEdge  ?? previousTileConfig.first
    enterEdge = enterEdge ?? targetTileConfig.first
    
    return (previousExit: exitEdge, targetEnterEdge: enterEdge, compatible: areCompatible)
    
}
