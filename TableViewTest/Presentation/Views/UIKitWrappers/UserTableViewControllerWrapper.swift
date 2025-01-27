//
//  UserTableViewControllerWrapper.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import SwiftUI
import UIKit

struct UsersTableViewControllerWrapper: UIViewControllerRepresentable {

	func makeUIViewController(context: Context) -> UsersTableViewController {
		let viewModel = UserViewModel()
		return UsersTableViewController(viewModel: viewModel)
	}

	func updateUIViewController(_ uiViewController: UsersTableViewController, context: Context) {
		// Update viewController if needed
	}

}
