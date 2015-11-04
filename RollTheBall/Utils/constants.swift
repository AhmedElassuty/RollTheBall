//
//  constants.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/30/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

let MIN_ROWS = 3
let MIN_COLS = 3
let MAX_ROWS = 10
let MAX_COLS = 10

let TILE_CONFIG: [[Edge]] = [
    [.Left, .Right],
    [.Left, .Top],
    [.Left, .Bottom],
    [.Right, .Top],
    [.Right, .Bottom],
    [.Top, .Bottom]
]

let BLANK_TILE_PERCENTAGE: Float = 30/100 // 30% of Total Tiles
let BLOCK_TILE_PERCENTAGE: Float = 10/100 // 30% of Total Tiles
let FIXED_TILE_PERCENTAGE: Float = 10/100 // 10% of Path Tiles




