//
//  constants.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/30/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

// constants to control the max and min
// dimensions of the generated board
let MIN_ROWS = 3
let MIN_COLS = 3
let MAX_ROWS = 3
let MAX_COLS = 3

// Constant array represents the six different
// configurations of Pathtiles
let TILE_CONFIG: [[Edge]] = [
    [.Left, .Right],
    [.Left, .Top],
    [.Left, .Bottom],
    [.Right, .Top],
    [.Right, .Bottom],
    [.Top, .Bottom]
]

// Constant variables controls the percentage
// of each tile type in the generated board
let BLANK_TILE_PERCENTAGE: Float = 30/100 // 30% of Total Tiles
let BLOCK_TILE_PERCENTAGE: Float = 10/100 // 30% of Total Tiles
let FIXED_TILE_PERCENTAGE: Float = 10/100 // 10% of Path Tiles




