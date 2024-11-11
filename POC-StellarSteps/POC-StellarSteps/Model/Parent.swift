import Foundation
import SwiftData

@Model
class Parent: Identifiable {
    var name: String
    @Relationship(deleteRule: .nullify, inverse: \Child.parent) var children: [Child]
    var pin: Int
    
    init(name: String, children: [Child], pin: Int) {
        self.name = name
        self.children = children
        self.pin = pin
    }
}
