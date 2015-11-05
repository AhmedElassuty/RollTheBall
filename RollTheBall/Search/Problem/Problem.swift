//
//  Problem.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/3/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

// Problem ADT
// Consructs 5 tuples of generic search problem
class Problem {
    var operators: [Operator]!
    var initialState: [[Tile]]!

    // all accessible states from the intial state
    // type: Hash
    // key: unique value generated by hashing the grid
    // value 2d array of tiles represents the actual state
    var stateSpace: [String: [[Tile]]] = [String: [[Tile]]]()
    
    // Intializer
    init(grid: [[Tile]]){
        self.initialState = grid

        // hashing the initialState
        let initialStateHashValue = hashGrid(self.initialState)

        // Add it to the stateSpace
        self.stateSpace[initialStateHashValue] = self.initialState
    }
    
    
    
    // goal test
    // Abstract method and must be implemented by subclasses 
    // return true if the input state is a goal state
    // return false if the input is not a goal state
    func goalState(stateHashValue: String) -> Bool {
        assert(false, "This method must be overrided by the subclass")
    }
    
}