//
//  UserViewModel.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import Foundation

class UserViewModel {
	private var users = [User]()

	private let networkService: NetworkService

	init(networkService: NetworkService = NetworkService.shared) {
		self.networkService = networkService
	}

	func fetchUsers(completion: @escaping (Result<Void, Error>) -> Void) {
		self.networkService.request(
			endpoint: Endpoint.users,
			method: .get,
			responseType: [UserResponse].self
		) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				self.users = response.map { $0.toDomain() }
				completion(.success(()))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func numberOfUsers() -> Int {
		return users.count
	}

	func userAt(index: Int) -> User {
		return users[index]
	}
}
