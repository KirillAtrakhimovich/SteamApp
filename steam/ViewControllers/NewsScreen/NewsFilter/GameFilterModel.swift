import Foundation

class GameFilterModel {
    var id: Int
    var name: String
    var isChecked: Bool
    
    init(id: Int, name: String, isChecked: Bool) {
        self.id = id
        self.name = name
        self.isChecked = isChecked
    }
    
}
