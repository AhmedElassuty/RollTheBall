//
//  Problem.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/3/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Problem {
    var actions: [Operator]!
    var initialState: [[Tile]]!
    // state space
    // path cost
    // goal test
    
    static func goalState(state: [[Tile]]) -> Bool{
        return false
    }
    
}