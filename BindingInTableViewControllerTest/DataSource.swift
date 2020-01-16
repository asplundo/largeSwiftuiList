//
// Created by me
  

import Foundation

class DataSource: ObservableObject {
    
    static let randomNames = ["Billie", "Alice", "Disa", "Olle", "Thure", "Åsa", "Lena", "Nalle"]
    
    @Published var users: [User] = Array(1...8000).map { User(name: "\(DataSource.randomNames.randomElement()!) \($0)") }
}

class User: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
