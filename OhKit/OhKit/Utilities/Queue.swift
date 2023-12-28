//
//  Queue.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 28/12/2023.
//

internal struct Queue<Element> {
    
    // MARK: - Properties
    
    private lazy var queueStorage: [Element] = {
        var baseQueue: [Element] = .init()
        baseQueue.reserveCapacity(16)
        return baseQueue
    }()
    
}


// MARK: - Operations

extension Queue {

    mutating func isEmpty() -> Bool {
        return self.peek() == nil
    }
    
    mutating func enqueue(_ element: Element) {
        queueStorage.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        return self.isEmpty() == false ? queueStorage.removeFirst() : nil
    }
    
    mutating func peek() -> Element? {
        return queueStorage.last
    }


}
