//
//  helpers.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/4/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

// input: 2d array of tiles
// output: Generates a string that uniquely identifies the
// the input grid based on the tile types and location
func hashGrid(grid: [[Tile]]) -> String {
    var hashValue = ""
    for row in grid {
        for tile in row {
            hashValue += stateSpaceId(tile)
        }
    }
    return hashValue
}

// input: Tile
// output: unique charachter per each tile type
func stateSpaceId(tile: Tile) -> String {
    switch(tile){
    case is GoalTile:
        return "G"
    case is InitialTile:
        return "I"
    case is BlankTile:
        return "_"
    case is BlockTile:
        return "B"
    case let tile as PathTile:
        return String(TILE_CONFIG.indexOf {$0 == tile.config}!)
    default:
        break
    }
    return ""
}

// Generates random 2d array of Tiles
func genGrid() -> [[Tile]] {
    let dimensions = initDimensions()
    var grid: [[Tile]] = [[Tile]]()
    
    let numberOfNonInitialTiles: Float = Float(dimensions.rows * dimensions.cols) - 2
    let numberOfBlockTiles:Int = Int(numberOfNonInitialTiles * BLOCK_TILE_PERCENTAGE)
    let numberOfBlankTiles:Int = Int(numberOfNonInitialTiles * BLANK_TILE_PERCENTAGE)
    let numberOfPathTiles:Int  = Int(numberOfNonInitialTiles) - numberOfBlockTiles - numberOfBlankTiles
    var numberOfFixedPathTiles:Int =  Int(Float(numberOfPathTiles) * FIXED_TILE_PERCENTAGE)
    
    print("Number oF Block Tiles      = \(numberOfBlockTiles)")
    print("Number oF Blank Tiles      = \(numberOfBlankTiles)")
    print("Number oF Path Tiles       = \(numberOfPathTiles)")
    print("Number oF Fixed Path Tiles = \(numberOfFixedPathTiles)")
    print("Dimensions (rowsxcols)     = \(dimensions.rows)x\(dimensions.cols)")
    
    enum TileTypes {
        case Blank, Path, Block, Initial, Goal
    }
    var types: [TileTypes] = [.Initial, .Goal]
    if numberOfBlockTiles-1 >= 0 {
        for _ in 0...numberOfBlockTiles-1 {
            types.append(.Block)
        }
    }

    for _ in 0...numberOfBlankTiles-1 {
        types.append(.Blank)
    }
    
    var pathTileConfigs = TILE_CONFIG
    var pathTileTypes: [[Edge]]! = []
    
    for _ in 0...numberOfPathTiles-1 {
        types.append(.Path)
        if pathTileConfigs.isEmpty{
            pathTileConfigs = TILE_CONFIG
            for i in 0 ..< (pathTileConfigs.count - 1) {
                let j = Int(arc4random_uniform(UInt32(pathTileConfigs.count - i))) + i
                if i != j{
                    swap(&pathTileConfigs[i], &pathTileConfigs[j])
                }
                
            }
        }
        pathTileTypes.append(pathTileConfigs.removeFirst())
    }
    
    print("Number oF Types            = \(types.count)")
    
    
    // Shuffle Types
    var initIndex:Int!
    var goalIndex:Int!
    repeat{
        for i in 0 ..< (types.count - 1) {
            let j = Int(arc4random_uniform(UInt32(types.count - i))) + i
            if i != j{
                swap(&types[i], &types[j])
            }
            
        }
        initIndex = types.indexOf {$0 == .Initial}
        goalIndex = types.indexOf {$0 == .Goal}
    }while (initIndex-1 ==  goalIndex || initIndex+1 ==  goalIndex || initIndex%dimensions.cols ==  goalIndex%dimensions.cols)
 
    
    // Create Tiles
    for row in 0...dimensions.rows-1 {
        grid.append([])
        for col in 0...dimensions.cols-1 {
            let location = Location(row: row , col: col)
            switch(types.removeFirst()){
            case .Blank:
                grid[row].append(BlankTile(location: location))
            case .Goal:
                grid[row].append(GoalTile(location: location, edge: getValidEdge(location, dimentions: dimensions)))
            case .Block:
                grid[row].append(BlockTile(location: location))
            case .Path:
                grid[row].append(PathTile(location: location, config: pathTileTypes.removeFirst(), fixed: false))
            case .Initial:
               grid[row].append(InitialTile(location: location, edge: getValidEdge(location, dimentions: dimensions)))
            }
            //grid[row-1].append()
        }
    }
    print("Grid Hash                  = \(hashGrid(grid))")
    visualizeBoard(grid)
    return grid
}

func visualizeBoard(grid: [[Tile]]){
    let rightSeparator = "|", leftSeparator = "|", topSeparator = "¯", bottomSeparator = "_"
    let rightArrow = "→", leftArrow = "←", topArrow = "↑", bottomArrow = "↓"
    var right = rightSeparator, left = leftSeparator, top = topSeparator, bottom = bottomSeparator
    var horizontalBorder = " ", topHorizontalSpace = "|", bottomHorizontalSpace = "|", horizontalvalues = "|"
    for _ in 0...grid[0].count-1 {
        horizontalBorder += "        "
    }
    print(horizontalBorder)
    for row in 0...grid.count-1 {
        horizontalvalues = " " ; topHorizontalSpace = " " ; bottomHorizontalSpace = " "
        for tile in grid[row] {
            switch tile {
            case is PathTile:
                right  = (tile as! PathTile).config.contains(.Right)  ? rightArrow : rightSeparator
                left   = (tile as! PathTile).config.contains(.Left)   ? leftArrow : leftSeparator
                top    = (tile as! PathTile).config.contains(.Top)    ? topArrow : topSeparator
                bottom = (tile as! PathTile).config.contains(.Bottom) ? bottomArrow : bottomSeparator
                
            case is GoalTile:
                right  = (tile as! GoalTile).enterEdge == .Right    ? rightArrow : rightSeparator
                left   = (tile as! GoalTile).enterEdge == .Left     ? leftArrow  : leftSeparator
                top    = (tile as! GoalTile).enterEdge == .Top      ? topArrow : topSeparator
                bottom = (tile as! GoalTile).enterEdge == .Bottom   ? bottomArrow : bottomSeparator
                
            case is InitialTile:
                right  = (tile as! InitialTile).exitEdge == .Right   ? rightArrow : rightSeparator
                left   = (tile as! InitialTile).exitEdge == .Left    ? leftArrow : leftSeparator
                top    = (tile as! InitialTile).exitEdge == .Top     ? topArrow : topSeparator
                bottom = (tile as! InitialTile).exitEdge == .Bottom  ? bottomArrow : bottomSeparator
            default:
                right = rightSeparator ; left = leftSeparator ; top = topSeparator ; bottom = bottomSeparator
                break
            }
            topHorizontalSpace += "|\(topSeparator + topSeparator + top + topSeparator + topSeparator)| "
            horizontalvalues += "\(left)  \(stateSpaceId(tile))  \(right) "
            bottomHorizontalSpace += "|\(bottomSeparator + bottomSeparator + bottom + bottomSeparator + bottomSeparator)| "
        }
 
        
        print(topHorizontalSpace)
        print(horizontalvalues)
        print(bottomHorizontalSpace)
        print(horizontalBorder)
    }
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
}

// returns random dimensions (rows, cols) for the new grid
func initDimensions() -> (rows: Int, cols: Int) {
    let r = (MIN_ROWS...MAX_ROWS).randomInt
    let c = (MIN_COLS...MAX_COLS).randomInt
    if r - c > 2 || c - r > 2 {
       return initDimensions()
    }
    return (rows: r, cols: c)
}


func getValidEdge(location: Location, dimentions: (rows: Int, cols:Int)) -> Edge {
    var validEdges: [Int: Edge] = [ Edge.Left.rawValue: .Left, Edge.Right.rawValue: .Right, Edge.Top.rawValue: .Top, Edge.Bottom.rawValue: .Bottom]
        if location.row == (dimentions.rows - 1) {
            validEdges.removeValueForKey(Edge.Bottom.rawValue)
        }
    
        if location.row == 0 {
            validEdges.removeValueForKey(Edge.Top.rawValue)
        }
    
        if location.col == (dimentions.cols - 1) {
            validEdges.removeValueForKey(Edge.Right.rawValue)
        }
    
        if location.col == 0 {
            validEdges.removeValueForKey(Edge.Left.rawValue)
        }

        return Edge.random(validEdges.values.reduce([Edge](), combine: {
            (var result: [Edge], edge: Edge) -> [Edge] in
            result.append(edge)
            return result
            }))
    }