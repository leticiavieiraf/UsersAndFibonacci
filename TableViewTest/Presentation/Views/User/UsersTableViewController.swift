//
//  UserListView.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import UIKit

class UsersTableViewController: UITableViewController {

	private let viewModel: UserViewModel!

	init(viewModel: UserViewModel) {
		self.viewModel = viewModel
		super.init(style: .plain)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		fetchUsers()
	}

	private func setupTableView() {
		tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.cellReuseID)
	}

	private func fetchUsers() {
		viewModel.fetchUsers { [weak self] result in
			switch result {
			case .success():
				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
			case .failure(let error):
				DispatchQueue.main.async {
					let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "OK", style: .default))
					self?.present(alert, animated: true)
				}
			}
		}
	}

	// MARK: - TableView DataSource

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfUsers()
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.cellReuseID, for: indexPath) as? UserCell else {
			fatalError("Could not dequeueReusableCell")
		}
		let user = viewModel.userAt(index: indexPath.row)
		let data = UserCell.Data(title: user.name, subtitle: user.email)
		cell.configure(with: data)
		cell.selectionStyle = .none
		return cell
	}
}
