//
//  PathTile.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation


class PathTile: Tile {
    var start: Edge!
    var end  : Edge!
    
    init(location: Location, edges: (start: Edge, end: Edge), fixed: Bool) {
        super.init(location: location, fixed: fixed)
        self.start = edges.start
        self.end = edges.end
    }
    
    func hasCompatableEdgeWith(edge: Edge) -> Bool {
        if start.isCompatableWith(edge) || end.isCompatableWith(edge) {
            return true
        }
        return false
    }
}