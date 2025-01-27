//
//  SceneDelegate.swift
//  TableViewTest
//
//  Created by Letícia Vieira Fernandes on 4/12/23.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		window = UIWindow(windowScene: windowScene)

		// MARK: - SwiftUI
		window?.rootViewController = UIHostingController(rootView: MenuSwiftUIView())
		window?.makeKeyAndVisible()

		// MARK: - UIKit
//		let rootViewController = UsersTableViewController(viewModel: UserViewModel())
//		window?.rootViewController = UINavigationController(rootViewController: rootViewController)
//		window?.makeKeyAndVisible()
	}
}

