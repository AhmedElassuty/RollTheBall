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
    
    static func random() -> Edge! {
        return Edge(rawValue: Int(arc4random_uniform(4)))
    }

    static func random(validEdges: [Edge]) -> Edge! {
        if validEdges.isEmpty {
            return nil
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
    
    func compatableEdge() -> Edge {
        var rawValue: Int
        if self.rawValue == 0 || self.rawValue == 2{
            rawValue = 1
        } else {
            rawValue = -1
        }
        
        return Edge(rawValue: self.rawValue + rawValue)!
    }
    
    func isCompatableWith(edge: Edge) -> Bool{
        if (self.compatableEdge() == edge) {
            return true
        }
        
        return false
    }
    
    func translationFactor() -> Location {
        switch self {
        case .Right:
            return Location(row: 0, col: 1)
        case .Left:
            return Location(row: 0, col: -1)
        case .Top:
            return Location(row: -1, col: 0)
        case .Bottom:
            return Location(row: 1, col: 0)
        }
    }
}