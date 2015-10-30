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
typealias Successor = (pathCost: Int!, node: Node!)

//struct Successor {
//    var pathCost: Int!
//    var node: Node
//}

class Node {
    // Instance properties
    var successors: [Successor]
    var hValue: Int?
    
    // Initializers
    init(){
        successors = []
    }
    
    init(hValue: Int){
        self.hValue = hValue
        successors = []
    }

    init(successors: [Successor]){
        self.successors = successors
    }
    
    init(hValue: Int, successors: [Successor]){
        self.hValue = hValue
        self.successors = successors
    }
    
    // Methods
    func leaf() -> Bool{
        return successors.isEmpty
    }
    
    func AddSuccessor(successor: Successor){
        successors.append(successor)
    }

}