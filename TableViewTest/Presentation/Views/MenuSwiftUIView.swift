//
//  SwiftUIView.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import SwiftUI

struct MenuSwiftUIView: View {

	var body: some View {
		NavigationView {
			VStack(spacing: 24) {
				Text("Samples:")

				NavigationLink(
					destination: UsersTableViewControllerWrapper()
				) {
					Text("Fetch users")
						.foregroundColor(.blue)
				}

				NavigationLink(
					destination: FibonacciViewControllerWrapper()
				) {
					Text("Fibonacci")
						.foregroundColor(.blue)

				}
			}
		}
	}
}

#Preview {
	MenuSwiftUIView()
}
