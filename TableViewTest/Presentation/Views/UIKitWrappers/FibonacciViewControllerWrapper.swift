//
//  FibonacciViewControllerWrapper.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import SwiftUI
import UIKit

struct FibonacciViewControllerWrapper: UIViewControllerRepresentable {

	func makeUIViewController(context: Context) -> FibonacciViewController {
		let viewModel = FibonacciViewModel()
		return FibonacciViewController(viewModel: viewModel)
	}

	func updateUIViewController(_ uiViewController: FibonacciViewController, context: Context) {
		// Update viewController if needed
	}
}
