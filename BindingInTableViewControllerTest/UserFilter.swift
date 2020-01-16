//
// Created by me
  

import SwiftUI

struct UserFilter: UIViewControllerRepresentable {

    @Binding var filter: String
    @EnvironmentObject var dataSource: DataSource
    
    func makeUIViewController(context: Context) -> UsersTableViewController {
        let vc = UsersTableViewController()
        vc.tableView.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ vc: UsersTableViewController, context: Context) {
        if filter.isEmpty {
            vc.users = dataSource.users
        } else {
            vc.users = dataSource.users.filter { $0.name.lowercased().contains(filter.lowercased()) }
        }
        vc.tableView.reloadData()
    }
    
    func makeCoordinator() -> UserFilter.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITableViewDelegate {
        
        var parent: UserFilter
        
        init(_ parent: UserFilter) {
            self.parent = parent
        }
        
        var filter: String {
            return parent.filter
        }
        
        var users: [User] {
            return parent.dataSource.users
        }
    }
}

class UsersTableViewController: UITableViewController {
    
    var users: [User] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        self.tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
}

class UserCell: UITableViewCell {
    
    static let reuseIdentifier = "userCell"

}
