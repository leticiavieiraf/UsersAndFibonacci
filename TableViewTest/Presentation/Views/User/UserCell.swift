//
//  UserCell.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import UIKit

class UserCell: UITableViewCell {

	static let cellReuseID = "UserCell"
	
	enum Margins {
		static let iconSize: CGFloat = 40
		static let margin: CGFloat = 24
		static let iconSpacing: CGFloat = 16
		static let textSpacing: CGFloat = 4
	}

	struct Data {
		var title: String
		var subtitle: String
	}

	private lazy var iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "person.circle")
		imageView.tintColor = .darkGray
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .darkGray
		label.numberOfLines = 0
		label.textAlignment = .left
		return label
	}()

	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .gray
		label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
		label.numberOfLines = 0
		label.textAlignment = .left
		return label
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
		contentView.addSubview(subtitleLabel)
	}

	private func setupConstraints() {
		iconImageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			iconImageView.widthAnchor.constraint(equalToConstant: Margins.iconSize),
			iconImageView.heightAnchor.constraint(equalToConstant: Margins.iconSize),

			iconImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
			iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.margin),

			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.margin),
			titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Margins.iconSpacing),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.margin),

			subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margins.textSpacing),
			subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margins.margin),
		])
	}

	public func configure(with data: Data) {
		titleLabel.text = data.title
		subtitleLabel.text = data.subtitle.lowercased()
	}
}
