//
//  Queue.swift
//  RollTheBall
//
//  Created by Ahmed Elassuty on 11/3/15.
//  Copyright © 2015 Mohamed Diaa. All rights reserved.
//

import Foundation

class Queue<T> {
    // Instance Variables
    private var data: [T]

    var isEmpty: Bool {
        return data.isEmpty
    }

    var count: Int {
        return data.count
    }
    
    var values: [T] {
        return data
    }

    // Intializers
    init(){
        self.data = []
    }
    
    init(data: T){
        self.data = []
        self.data.append(data)
    }
    
    // Functions
    func dequeue() -> T {
        return data.removeAtIndex(0)
    }
    
    func enqueue(value: T, insertionFunc: (([T]) -> Int)){
        data.insert(value, atIndex: insertionFunc(self.data))
    }
    
    func enqueue(values: [T], insertionFunc: (([T]) -> Int)){
        for value in values {
            data.insert(value, atIndex: insertionFunc(self.data))
        }
    }

    func enqueue(values: [T], insertionFunc: (Array<T>, T, T -> Int) -> Int, evalFunc: T -> Int) {
        for value in values {
            data.insert(value, atIndex: insertionFunc(self.data, value, evalFunc))
        }
    }
}

