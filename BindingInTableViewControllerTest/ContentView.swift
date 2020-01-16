//
// Created by me
  

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dataSource: DataSource
    @State private var filter = ""
    @State private var presentSheet = false
    
    var body: some View {
        VStack {
            Button("Open") {
                self.presentSheet.toggle()
            }
            TextField("Find user...", text: $filter)
            UserFilter(filter: $filter)
        }
        .sheet(isPresented: $presentSheet) {
            SearchUsersView(filter: self.$filter).environmentObject(self.dataSource)
        }
    }
    
    var users: [User] {
        if filter.isEmpty {
            return dataSource.users
        }
        return dataSource.users.filter { $0.name.lowercased().contains(filter.lowercased()) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
