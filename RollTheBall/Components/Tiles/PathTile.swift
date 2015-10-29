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
    
    init(xPostion: Int, yPostion: Int, start:Edge, end: Edge) {
        super.init(xPostion: xPostion, yPostion: xPostion)
        
        if start == end {
            print("ERROR: Cannot start and End at the same Edge")
        }
        self.end = end
        self.start = start
    }
}