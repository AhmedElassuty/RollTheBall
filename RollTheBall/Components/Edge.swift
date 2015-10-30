//
//  edge.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/30/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

enum Edge: Int {
    case Right, Left, Top, Bottom

    static func random(validEdges: Edge...) -> Edge! {
        if validEdges.isEmpty {
            return Edge(rawValue: Int(arc4random_uniform(4)))
        }

        var rawValues: [Int] = []
        for validEdge in validEdges {
            rawValues.append(validEdge.rawValue)
        }
        let randIndex = Int.random(rawValues.count)
        
        return Edge(rawValue: rawValues[randIndex])
    }
    
    static func randomPair() -> (start: Edge!, end: Edge!){
        let start =  Edge.random()
        var end: Edge

        repeat {
            end = Edge.random()
        } while end == start
        
        return (start: start, end: end)
    }
}