//
//  FibonacciViewModel.swift
//  TableViewTest
//
//  Created by Letícia Fernandes on 27/01/25.
//

class FibonacciViewModel {

	func fibonacciList(positionsQty: Int) -> [String] {
		var fibonacciList: [String] = []

		for x in 0..<positionsQty {
			let value = iterativeFib(x)
			let valueFormatted = "fib(\(x)) = \(value)"
			fibonacciList.append(valueFormatted)
		}

		return fibonacciList
	}

	func recursiveFib(_ x: Int) -> Int {
		if x == 0 || x == 1 {
			return x
		}
		let result = recursiveFib(x - 1) + recursiveFib(x - 2)
		return result
	}

	// Better performance as it keeps track of results, avoids rendundant calculation
	func iterativeFib(_ x: Int) -> Int {
		var v0: Int = 0
		var v1: Int = 0
		var result: Int = 1

		if x == 0 || x == 1 {
			return x
		}

		for _ in 2...x {
			v0 = v1
			v1 = result
			result = v0 + v1
		}
		return result
	}
}
