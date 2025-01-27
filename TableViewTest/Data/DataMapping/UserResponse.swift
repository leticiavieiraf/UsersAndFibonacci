//
//  UserResponse.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

import Foundation

struct UserResponse: Decodable {
	let id: Int
	let name: String
	let username: String
	let email: String

	public func toDomain() -> User {
		User(id: self.id, name: self.name, username: self.username, email: self.email)
	}
}

