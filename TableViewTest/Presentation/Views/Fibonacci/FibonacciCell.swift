//
//  FibonacciTableViewCell.swift
//  TableViewTest
//
//  Created by Letícia Vieira Fernandes on 5/12/23.
//

import UIKit

class FibonacciCell: UITableViewCell {

	static let cellReuseID = "FibonacciCell"
	
	enum Margins {
		static let iconSize: CGFloat = 40
		static let margin: CGFloat = 24
		static let buttonSize: CGFloat = 40
		static let iconSpacing: CGFloat = 16
		static let textSpacing: CGFloat = 4
	}

	struct Data {
		var title: String
		var actionButton: () -> Void
	}

	private lazy var iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "number.circle")
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .darkGray
		return imageView
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .gray
		label.numberOfLines = 0
		label.textAlignment = .left
		return label
	}()

	private lazy var button: UIButton = {
		let bt = UIButton()
		bt.setTitleColor(.blue, for: .normal)
		bt.setTitle("Print result", for: .normal)
		bt.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
		return bt
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	private func setupUI() {
		addSubviews()
		setupConstraints()
	}

	private func addSubviews() {
		contentView.addSubview(iconImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(button)
	}

	private func setupConstraints() {
		iconImageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		button.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			iconImageView.widthAnchor.constraint(equalToConstant: Margins.iconSize),
			iconImageView.heightAnchor.constraint(equalToConstant: Margins.iconSize),

			iconImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
			iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.margin),

			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.margin),
			titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Margins.iconSpacing),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.margin),

			button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margins.textSpacing),
			button.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margins.margin),
			button.heightAnchor.constraint(equalToConstant: Margins.buttonSize),
		])
	}

	public func configure(with data: Data) {
		titleLabel.text = data.title
		button.addAction(UIAction(handler: { _ in
			data.actionButton()
		}), for: .touchUpInside)
	}
}

