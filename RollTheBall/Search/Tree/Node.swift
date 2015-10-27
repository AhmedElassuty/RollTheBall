//
//  Node.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Node {
    struct NodePath {
        var pathCost : Int!
        var node : Node
    }
    
    var successors : [NodePath]!
    var value : Int?
}