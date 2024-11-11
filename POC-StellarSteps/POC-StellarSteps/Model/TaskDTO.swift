import Foundation
import SwiftData

@Model
class TaskDTO: Identifiable {
    var id: UUID
    var name: String
    var duration: Int
    var category: Category
    var info: String
    var childTips: String
    
    init(id: UUID = UUID(), name: String, duration: Int, category: Category, info: String, childTips: String) {
        self.id = id
        self.name = name
        self.duration = duration
        self.category = category
        self.info = info
        self.childTips = childTips
    }
}
