//
//  Location.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/6/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

struct Location {
    var row: Int!
    var col: Int!
    
    init(row: Int!, col: Int!){
        self.row = row
        self.col = col
    }
    
    func equal(location: Location) -> Bool {
        if self.row == location.row && self.col == self.col {
            return true
        }
        return false
    }
    
    func translate(factor: Location) -> Location {
        return Location(row: self.row + factor.row, col: self.col + factor.col)
    }
    
    func withInRange(row: Int, col: Int) -> Bool {
        if self.row < 0 || self.row >= row || self.col < 0 || self.col >= col {
            return false
        }
        return true
    }
    
    func toString() -> String! {
        return "(\(self.row), \(self.col))"
    }
}