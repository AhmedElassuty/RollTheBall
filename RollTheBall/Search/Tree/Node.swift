//
//  Node.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

// Helper data structure represents
// a successor node in the tree


class Node {
    // Instance properties
    var parentNode: Node!
    var state: [[Tile]]!
    var successors: [Node]
    var depth:Int!
    var pathCost: Int!
    var hValue: Int?
    
    // Initializers
    init(){
        successors = []
    }
    
    init(hValue: Int){
        self.hValue = hValue
        successors = []
    }
    
    init(successors: [Node]){
        self.successors = successors
    }
    
    init(hValue: Int, successors: [Node]){
        self.hValue = hValue
        self.successors = successors
    }
    
    // Methods
    func leaf() -> Bool{
        return successors.isEmpty
    }
    
    func AddSuccessor(successor: Node){
        successors.append(successor)
    }
    
}