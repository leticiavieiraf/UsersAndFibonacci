import PlaygroundSupport
import UIKit
import Foundation

class MyViewController: UIViewController {

	private lazy var baseScrollView: UIScrollView = { return UIScrollView(frame: .zero) }()

	private lazy var logoImageView: UIImageView = { return UIImageView(frame: .zero) }()
	private lazy var loginLabel: UILabel = { return UILabel(frame: .zero) }()
	private lazy var loginTextField: UITextField = { return UITextField(frame: .zero) }()
	private lazy var passwordLabel: UILabel = { return UILabel(frame: .zero) }()
	private lazy var passwordTextField: UITextField = { return UITextField(frame: .zero) }()
	private lazy var mainButton: UIButton = { UIButton(frame: .zero) }()
	private lazy var stackView: UIStackView = { return UIStackView(frame: .zero) }()

	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		buildHierarchy()
		setupConstraints()
		configureViews()
	}

	// MARK: - Actions
	@objc
	func enterButtonTapped()  {
		print("heyyy")
	}
}

// MARK: - ViewCodeConfiguration
extension MyViewController {
	func buildHierarchy() {
		view.addSubview(baseScrollView)
		baseScrollView.addSubviews(logoImageView,
							   loginLabel,
							   loginTextField,
							   passwordLabel,
							   passwordTextField,
							   mainButton,
							   stackView)
	}

	func setupConstraints() {
		baseScrollView.setConstraints((BondType.fillSuperView, toView: view))

		logoImageView.setConstraints(([.width(135), .height(55), .sameCenterX, .marginFromTop(100)], toView: baseScrollView))

		loginLabel.setConstraints(([.marginFromAbove(100)], toView: logoImageView),
								  ([.horizontalMargin(32), .sameCenterX], toView: baseScrollView))

		loginTextField.setConstraints(([.height(40), .marginFromAbove(8), .bondToLeading, .bondToTrailing], toView: loginLabel))

		passwordLabel.setConstraints(([.marginFromAbove(24), .bondToLeading, .bondToTrailing], toView: loginTextField))
		passwordTextField.setConstraints(([.height(40), .marginFromAbove(8), .bondToLeading, .bondToTrailing], toView: passwordLabel))

		mainButton.setConstraints(([.marginFromAbove(40), .bondToLeading, .bondToTrailing, .height(40)], toView: passwordTextField))

		stackView.setConstraints(([.marginFromAbove(32), .bondToLeading, .bondToTrailing], toView: mainButton),
								 ([.marginFromBottom(24)], toView: baseScrollView))
	}

	func configureViews() {
		view.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
		view.backgroundColor = .black

		logoImageView.contentMode = .scaleAspectFit
		logoImageView.image = UIImage(named: "logo-login")

		loginLabel.text = "Search"
		loginLabel.textColor = .white

		loginTextField.backgroundColor = .white
		loginTextField.layer.cornerRadius = 16
		loginTextField.placeholder = "Type something here"
		loginTextField.textAlignment = .left
		loginTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)


		passwordLabel.text = "Senha"
		passwordLabel.textColor = .white
		passwordLabel.isHidden = true

		passwordTextField.backgroundColor = .white
		passwordTextField.layer.cornerRadius = 10
		passwordTextField.placeholder = "Digite sua senha"
		passwordTextField.textAlignment = .left
		passwordTextField.isHidden = true

		mainButton.layer.cornerRadius = 8
		mainButton.backgroundColor = .white
		mainButton.setTitle("Entrar", for: .normal)
		mainButton.setTitleColor(.black, for: .normal)
		mainButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)

		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 8.0

	}
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()






















// UIView+Bond.swift
enum BondType {
	case bondToTop
	case bondToBottom
	case bondToLeading
	case bondToTrailing
	case fillSuperView
	case fullWidth
	case fullHeight
	case width(CGFloat)
	case height(CGFloat)
	case sameCenterX
	case sameCenterY
	case sameCenter
	case marginFromLeading(CGFloat)
	case marginFromTrailing(CGFloat)
	case marginFromTop(CGFloat)
	case marginFromBottom(CGFloat)
	case marginFromBottomGreaterThanOrEqual(CGFloat)
	case marginFromLeft(CGFloat)
	case marginFromRight(CGFloat)
	case marginFromAbove(CGFloat)
	case marginFromBelow(CGFloat)
	case marginEqual(CGFloat)
	case verticalMargin(CGFloat)
	case horizontalMargin(CGFloat)
}

extension UIView {
	func addSubviews(_ viewsToAdd: UIView...) {
		viewsToAdd.forEach { (view) in
			self.addSubview(view)
		}
	}

	func removeSubviews() {
		self.subviews.forEach({$0.removeFromSuperview()})
	}

	typealias SingleConstraintToView = (BondType, toView: UIView?)
	func setConstraints(_ singleConstraintToView: SingleConstraintToView...) {
		singleConstraintToView.forEach { (type, toView) in
			self.setBond(type: type, toView: toView)
		}
	}

	typealias ConstraintsToView = ([BondType], toView: UIView?)
	func setConstraints(_ constraintsToView: ConstraintsToView...) {
		constraintsToView.forEach { (types, toView) in
			types.forEach {
				self.setBond(type: $0, toView: toView)
			}
		}
	}

	private func setBond(type: BondType, toView: UIView?) {
		guard let toView = toView else {
			self.setBond(type: type)
			return
		}
		self.translatesAutoresizingMaskIntoConstraints = false

		switch type {
		case .width(_), .height(_):
			self.setBond(type: type)
		case .fillSuperView:
			self.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
			self.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
			self.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true
		case .fullHeight:
			self.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
		case .fullWidth:
			self.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
			self.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true
		case .sameCenterX:
			self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
		case .sameCenterY:
			self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
		case .sameCenter:
			self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
			self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
		case .bondToTop:
			self.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
		case .bondToBottom:
			self.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
		case .marginFromTop(let margin):
			self.topAnchor.constraint(equalTo: toView.topAnchor, constant: margin).isActive = true
		case .marginFromBottom(let margin):
			self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -margin).isActive = true
		case .marginFromBottomGreaterThanOrEqual(let margin):
			let constraint = self.bottomAnchor.constraint(greaterThanOrEqualTo: toView.bottomAnchor, constant: margin)
			constraint.priority = .defaultLow
			constraint.isActive = true
		case .marginFromAbove(let margin):
			self.topAnchor.constraint(equalTo: toView.bottomAnchor, constant: margin).isActive = true
		case .marginFromBelow(let margin):
			self.bottomAnchor.constraint(equalTo: toView.topAnchor, constant: -margin).isActive = true
		case .bondToLeading:
			self.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
		case .bondToTrailing:
			self.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true
		case .marginFromLeading(let margin):
			self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: margin).isActive = true
		case .marginFromTrailing(let margin):
			self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -margin).isActive = true
		case .marginFromLeft(let margin):
			self.leadingAnchor.constraint(equalTo: toView.trailingAnchor, constant: margin).isActive = true
		case .marginFromRight(let margin):
			self.trailingAnchor.constraint(equalTo: toView.leadingAnchor, constant: -margin).isActive = true
		case .marginEqual(let margin):
			self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: margin).isActive = true
			self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -margin).isActive = true
			self.topAnchor.constraint(equalTo: toView.topAnchor, constant: margin).isActive = true
			self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -margin).isActive = true
		case .verticalMargin(let margin):
			self.topAnchor.constraint(equalTo: toView.topAnchor, constant: margin).isActive = true
			self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -margin).isActive = true
		case .horizontalMargin(let margin):
			self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: margin).isActive = true
			self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -margin).isActive = true
		}
	}

	private func setBond(type: BondType) {
		self.translatesAutoresizingMaskIntoConstraints = false

		switch type {
		case .width(let value):
			self.widthAnchor.constraint(equalToConstant: value).isActive = true
		case .height(let value):
			self.heightAnchor.constraint(equalToConstant: value).isActive = true
		default: break
		}
	}
}
