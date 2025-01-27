import UIKit

enum Constants {
    enum Margins {
        static let margin: CGFloat = 24
    }
}

class FibonacciViewController: UIViewController {

    private lazy var tableView = UITableView()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Enter a number", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

	private let viewModel: FibonacciViewModel
    private var data: [String] = []

    init(viewModel: FibonacciViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()

        setupTableView()
        setupButton()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		askForANumber()
	}

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(button)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constants.Margins.margin),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Margins.margin),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FibonacciCell.self, forCellReuseIdentifier: FibonacciCell.cellReuseID)
    }

    private func setupButton() {
        button.addTarget(self, action: #selector(askForANumber), for: .touchUpInside)
    }

    @objc
    private func askForANumber() {
        data = []
        let alert = UIAlertController(title: "Fibonacci", message: "Enter a number", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Enter here"
            textField.keyboardType = .numberPad
        }

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alert.textFields?.first, let text = textField.text {
                let number = Int(text) ?? 0
				self.handleInput(number: number)
            }
        }
        alert.addAction(action)

        navigationController?.present(alert, animated: true)
    }

	private func handleInput(number: Int) {
		DispatchQueue.global(qos: .background).async {
			self.data = self.viewModel.fibonacciList(positionsQty: number)

			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
}

extension FibonacciViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FibonacciCell.cellReuseID, for: indexPath) as? FibonacciCell else {
            fatalError("Could not dequeueReusableCell")
        }
        let resultText = data[indexPath.row]
		let cellData = FibonacciCell.Data(title: resultText) {
            print(resultText)
        }
        cell.configure(with: cellData)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension FibonacciViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataItem = data[indexPath.row]

        let detailViewModel = FibonacciDetailViewModel(contentText: dataItem)
        let detailViewController = FibonacciDetailViewController(viewModel: detailViewModel)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
