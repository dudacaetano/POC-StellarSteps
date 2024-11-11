import SwiftUI
import SwiftData

class ChildViewModel: ObservableObject {
    
    func add(name: String, age: Int, context: ModelContext) {
        
        let child = Child(name: name, age: age)
        context.insert(child)
        
        try? context.save()
    }
}
