import Foundation
import SwiftData

@Model
class TaskChild: Identifiable {
    var id: Int
    var name: String
    var duration: Int
    var category: Category
    var date: Date
    @Relationship(inverse: \Child.tasks) var child: Child
    var info: String
    var childTips: String
    var isCurrent: Bool
    var isStarted: Bool
    var isValidated: Bool
    var isCompleted: Bool
    
    init(id: Int, name: String, duration: Int, category: Category, date: Date, child: Child, info: String, childTips: String, isCurrent: Bool = false, isStarted: Bool = false, isValidated: Bool = false, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.duration = duration
        self.date = date
        self.category = category
        self.child = child
        self.info = info
        self.childTips = childTips
        self.isCurrent = isCurrent
        self.isStarted = isStarted
        self.isValidated = isValidated
        self.isCompleted = isCompleted
    }
}
