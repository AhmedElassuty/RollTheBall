//
//  BasicTile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/29/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

typealias InitialTile = GoalTile

class GoalTile: Tile {
    var opening: Edge!
    
    override init(xPosition: Int, yPosition: Int, isEmpty: Bool = false, canMove: Bool = false) {
        super.init(xPosition: xPosition, yPosition: yPosition)
    }
    
    init(location: (Int, Int), edge: Edge){
        super.init(location: location)
        opening = edge
    }

}