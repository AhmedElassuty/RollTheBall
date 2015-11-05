//
//  Operators.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/2/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

// enumerator represents the possible
// moves that the agent can perform
enum Operator: Int {
    case East, West, North, South
    
    func isInverseOf(oper: Operator) -> Bool {
        if (self == .East && oper == .West) || (self == .West && oper == .East) || (self == .North && oper == .South) || (self == .South && oper == .North){
            return true
        }

        return false
    }
    
    func inverse() -> Operator {
        switch self{
        case .West:
            return .East
        case .East:
            return .West
        case .North:
            return .South
        case .South:
            return .North
        }
    }
    
    func apply(oldLocation: Location) -> Location {
        var newLocation: Location
        switch self {
        case .East:
            newLocation = Location(row: oldLocation.row, col: oldLocation.col + 1)
        case .West:
            newLocation = Location(row: oldLocation.row, col: oldLocation.col - 1)
        case .North:
            newLocation = Location(row: oldLocation.row - 1, col: oldLocation.col)
        case .South:
            newLocation = Location(row: oldLocation.row + 1, col: oldLocation.col)
        }
        
        return newLocation
    }
    
    static func getAll() -> [Operator]{
        return [.East, .West, .North, .South]
    }

}

// Action class represents
// the operation applied to a specific tile
class Action {
    // variable represents the new location
    var location: Location

    // variable represents the move applied
    // to generate the new location
    var move: Operator
    
    // initializer
    // takes old location and the move
    init(location: Location, move: Operator){
        self.location = location
        self.move = move
    }

}