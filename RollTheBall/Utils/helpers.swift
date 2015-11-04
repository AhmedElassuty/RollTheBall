//
//  helpers.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/4/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation


func hashGrid(grid: [[Tile]]) -> String {
    var hashValue = ""
    for row in grid {
        for tile in row {
            hashValue += stateSpaceId(tile)
        }
    }
    return hashValue
}

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

func genGrid() -> [[Tile]] {
    let dimensions = initDimensions()
    var grid: [[Tile]] = [[Tile]]()
    
    let numberOfBlockTiles:Int = Int( Float(dimensions.rows * dimensions.cols) * BLOCK_TILE_PERCENTAGE)
    let numberOfBlankTiles:Int = Int( Float(dimensions.rows * dimensions.cols) * BLANK_TILE_PERCENTAGE)
    let numberOfPathTiles:Int = (dimensions.rows * dimensions.cols) - 2 - numberOfBlockTiles - numberOfBlankTiles
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
    for _ in 0...numberOfBlockTiles-1 {
        types.append(.Block)
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
    
    
    
    // Shuffle Types
    for i in 0 ..< (types.count - 1) {
        let j = Int(arc4random_uniform(UInt32(types.count - i))) + i
        if i != j{
            swap(&types[i], &types[j])
        }
        
    }
    
    // Create Tiles
    
    for row in 0...dimensions.rows-1 {
        grid.append([])
        for col in 0...dimensions.cols-1 {
            let location = Location(row: row , col: col)
            switch(types.removeFirst()){
            case .Blank:
                grid[row].append(BlankTile(location: location))
            case .Goal:
                grid[row].append(GoalTile(location: location, edge: findFreeEdge(location, dimentions: dimensions)))
            case .Block:
                grid[row].append(BlockTile(location: location))
            case .Path:
                grid[row].append(PathTile(location: location, config: pathTileTypes.removeFirst(), fixed: false))
            case .Initial:
               grid[row].append(InitialTile(location: location, edge: findFreeEdge(location, dimentions: dimensions)))
            }
            //grid[row-1].append()
            
        }
    }
    print("Grid Hash                  = \(hashGrid(grid))")
    visualizeBoard(grid)
    return grid
}

func visualizeBoard(grid: [[Tile]]){
    var horizontalBorder = "|", topHorizontalSpace = "|", bottomHorizontalSpace = "|", horizontalvalues = "|"
    for _ in 0...grid[0].count-1 {
        horizontalBorder += "_______|"
    }
    print(horizontalBorder)
    for row in 0...grid.count-1 {
        var right = "+", left = "+", top = "+", bottom = "+"
        horizontalvalues = "|"
        topHorizontalSpace = "|"
        bottomHorizontalSpace = "|"
        for tile in grid[row] {
            switch tile {
            case is PathTile:
                right  = (tile as! PathTile).config.contains(.Right)  ? " " : "+"
                left   = (tile as! PathTile).config.contains(.Left)   ? " " : "+"
                top    = (tile as! PathTile).config.contains(.Top)    ? " " : "+"
                bottom = (tile as! PathTile).config.contains(.Bottom) ? " " : "+"
            default:
                right = "+"; left = "+"; top = "+"; bottom = "+"
                break
            }
            topHorizontalSpace += "+++\(top)+++|"
            horizontalvalues += "\(left)  \(stateSpaceId(tile))  \(right)|"
            bottomHorizontalSpace += "+++\(bottom)+++|"
        }
        
        print(topHorizontalSpace)
        print(horizontalvalues)
        print(bottomHorizontalSpace)
        print(horizontalBorder)
    }
}


func initDimensions() -> (rows: Int, cols: Int) {
    let r = (MIN_ROWS...MAX_ROWS).randomInt
    let c = (MIN_COLS...MAX_COLS).randomInt
    if r - c > 2 || c - r > 2 {
       return initDimensions()
    }
    return (rows: r, cols: c)
}

func findFreeEdge(location: Location, dimentions: (rows: Int, cols:Int)) -> Edge{
    var edges: [Edge] = [.Right, .Left, .Top, .Bottom]
    
    if location.row+1 == dimentions.rows {
        return .Top
    }
    if location.row == 0 {
        return .Bottom
    }
    if location.col == 0 {
        return .Right
    }
    if location.col+1 == dimentions.cols {
        return .Left
    }
    return edges[(0...3).randomInt]
}