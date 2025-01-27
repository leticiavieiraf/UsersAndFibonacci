//
//  TableViewTestTests.swift
//  TableViewTestTests
//
//  Created by Letícia Fernandes on 27/01/25.
//

import XCTest
@testable import TableViewTest

class UserViewModelTests: XCTestCase {

	var viewModel: UserViewModel!
	var networkServiceMock: NetworkServiceMock!

	override func setUp() {
		super.setUp()
		networkServiceMock = NetworkServiceMock()
		viewModel = UserViewModel(networkService: networkServiceMock)
	}

	override func tearDown() {
		super.tearDown()
		viewModel = nil
		networkServiceMock = nil
	}

	// MARK: - Test Success Case

	func test_fetchUsers_success() {
		// Given
		let mockUsers = [
			UserResponse(id: 1, name: "João", username: "joaogf", email: "joao@example.com"),
			UserResponse(id: 2, name: "Alana", username: "alanatj", email: "alana@example.com"),
			UserResponse(id: 3, name: "Beatriz", username: "biajp", email: "bia@example.com")
		]
		networkServiceMock.mockResponse = .success(mockUsers)

		// When
		let expectation = self.expectation(description: "fetchUsers")
		viewModel.fetchUsers { result in
			// Then
			switch result {
			case .success:
				XCTAssertEqual(self.viewModel.numberOfUsers(), 3)
				XCTAssertEqual(self.viewModel.userAt(index: 0).name, "João")
				XCTAssertEqual(self.viewModel.userAt(index: 1).name, "Alana")
				XCTAssertEqual(self.viewModel.userAt(index: 2).name, "Beatriz")
			case .failure:
				XCTFail("Expected success but got failure")
			}
			expectation.fulfill()
		}
		waitForExpectations(timeout: 2.0, handler: nil)
	}

	// MARK: - Test Failure Case

	func test_fetchUsers_failure() {
		// Given
		networkServiceMock.mockResponse = .failure(NetworkError.invalidResponse)

		// When
		let expectation = self.expectation(description: "fetchUsers")
		viewModel.fetchUsers { result in
			// Then
			switch result {
			case .success:
				XCTFail("Expected failure but got success")
			case .failure(let error):
				XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
			}
			expectation.fulfill()
		}
		waitForExpectations(timeout: 2.0, handler: nil)
	}
}

class NetworkServiceMock: NetworkService {

	var mockResponse: Result<[UserResponse], NetworkError>?

	init(mockResponse: Result<[UserResponse], NetworkError>? = nil) {
		super.init(session: .shared)
		self.mockResponse = mockResponse
	}

	override func request<T>(
		endpoint: Endpoint,
		method: HTTPMethod = .get,
		parameters: [String : Any]? = nil,
		headers: [String : String]? = nil,
		responseType: T.Type,
		completion: @escaping (Result<T, NetworkError>) -> Void
	) where T : Decodable {
		if let mockResponse = mockResponse {
			completion(mockResponse as! Result<T, NetworkError>)
		}
	}
}
