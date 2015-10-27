//
//  Board.swift
//  RollTheBall
//
//  Created by Mohamed Diaa on 10/27/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Board {
    var m:Int!
    var n:Int!
    var tiles = [[Tile]]()
    
    init(m:Int, n:Int){
        self.m = m
        self.n = n
        generateRandomTiles()
    }
    
    func generateRandomTiles() -> Void {
        
    }
}