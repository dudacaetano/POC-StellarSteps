import SwiftUI
import SwiftData

class ParentsViewModel: ObservableObject {
    
    func add(name: String, children: [Child], pin: Int, context: ModelContext) {
        
        let parent = Parent(name: name, children: children, pin: pin)
        context.insert(parent)
        
        try? context.save()
    }
}
