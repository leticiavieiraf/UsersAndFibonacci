//
//  FibonacciDetailViewController.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import UIKit

class FibonacciDetailViewController: UIViewController {

	private lazy var textLabel: UILabel = {
		let label = UILabel()
		label.textColor = .gray
		return label
	}()

	private(set) var viewModel: FibonacciDetailViewModel?

	init(viewModel: FibonacciDetailViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		addSubviews()
		setupConstraints()
		setupView()
	}

	private func addSubviews() {
		view.addSubview(textLabel)
	}

	private func setupConstraints() {
		textLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			self.textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Margins.margin),
			self.textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
		])
	}

	private func setupView() {
		textLabel.text = viewModel?.contentText
	}
}
