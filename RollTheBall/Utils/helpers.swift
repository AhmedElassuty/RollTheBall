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

// Prints the input grid
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