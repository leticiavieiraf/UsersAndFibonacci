//
//  NetworkManager.swift
//  TableViewTest
//

import Foundation

enum Endpoint: String {
	case users = "/users"
}

public class NetworkService {

	static let shared = NetworkService()

	private let session: URLSession
	private let baseURL = "https://jsonplaceholder.typicode.com"

	init(session: URLSession = .shared) {
		self.session = session
	}

	func request<T: Decodable>(
		endpoint: Endpoint,
		method: HTTPMethod = .get,
		parameters: [String: Any]? = nil,
		headers: [String: String]? = nil,
		responseType: T.Type,
		completion: @escaping (Result<T, NetworkError>) -> Void
	) {

		guard let url = URL(string: baseURL + endpoint.rawValue) else {
			completion(.failure(.invalidURL))
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue

		if let headers = headers {
			headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
		}

		if let parameters = parameters {
			request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
		}

		session.dataTask(with: request) { (data, response, error) in
			if let _ = error {
				completion(.failure(.requestFailed))
				return
			}

			guard let data = data else {
				completion(.failure(.noData))
				return
			}

			guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
				completion(.failure(.invalidResponse))
				return
			}

			do {
				let decoder = JSONDecoder()
				let responseModel = try decoder.decode(T.self, from: data)
				completion(.success(responseModel))
			} catch {
				completion(.failure(.decodingError))
			}
		}.resume()
	}
}

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

enum NetworkError: Error, CustomStringConvertible {
	case invalidURL
	case requestFailed
	case invalidResponse
	case decodingError
	case noData

	var description: String {
		switch self {
		case .invalidURL:
			return "Invalid URL"
		case .requestFailed:
			return "Request failed"
		case .invalidResponse:
			return "Invalid response from server"
		case .decodingError:
			return "Error decoding the response"
		case .noData:
			return "No data received"
		}
	}
}
