import Foundation
import SwiftData

@Model
class Child: Identifiable {
    var name: String
    var age: Int
    var parent: Parent?
    var tasks: [TaskChild]
    init(name: String, age: Int, task: [TaskChild] = []) {
        self.name = name
        self.age = age
        self.tasks = task
    }
}

