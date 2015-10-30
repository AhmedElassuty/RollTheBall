//
//  extensions.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/30/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

extension Range {
    var randomInt: Int {
        get {
            let min = startIndex as! Int
            let max = endIndex as! Int
            return Int(arc4random_uniform(UInt32(max - min))) + min
        }
    }
}

extension Int {
    static func random(upperLimit: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upperLimit)))
    }

    static func randomPair(rows: Int, cols: Int) -> (row: Int, col: Int){
        return (row: (0...rows).randomInt, col: (0...cols).randomInt)
    }

}