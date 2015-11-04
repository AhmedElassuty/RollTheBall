//
//  PathTile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation


class PathTile: Tile {
    var config: [Edge]!
    var start: Edge!
    var end  : Edge!
    
    init(location: Location, config: [Edge], fixed: Bool) {
        super.init(location: location, fixed: fixed)
        self.config = config
    }
    
    func hasCompatableEdgeWith(edge: Edge) -> Bool {
        return !config.filter{$0.isCompatableWith(edge)}.isEmpty
    }
}