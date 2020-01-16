//
// Created by me
  

import SwiftUI

struct SearchUsersView: View {
    
    @EnvironmentObject var dataSource: DataSource
    @Binding var filter: String
    
    var body: some View {
        VStack {
            TextField("Find user...", text: $filter)
            List(users) { user in
                Text(user.name)
            }
            .id(UUID())
        }
    }
    
    var users: [User] {
        if filter.isEmpty {
            return dataSource.users
        }
        return dataSource.users.filter { $0.name.lowercased().contains(filter.lowercased()) }
    }
}

struct SearchUsersView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsersView(filter: .constant("test"))
    }
}
