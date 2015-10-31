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

//    init?(row: Int, col: Int, start: Edge, end: Edge) {
//        super.init(row: row, col: col)
//        if start == end {
//            print("ERROR: Cannot start and End at the same Edge")
//            return nil
//        }
//        self.end = end
//        self.start = start
//    }
    
    init(location: Location, edges: (start: Edge, end: Edge), fixed: Bool) {
        super.init(location: location, fixed: fixed)
        self.start = edges.start
        self.end = edges.end
    }
}