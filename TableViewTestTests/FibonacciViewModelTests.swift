//
//  FibonacciViewModelTest.swift
//  TableViewTestTests
//
//  Created by Letícia Fernandes on 27/01/25.
//

import XCTest
@testable import TableViewTest

final class FibonacciViewModelTests: XCTestCase {

	var viewModel: FibonacciViewModel!

	override func setUp() {
		super.setUp()
		viewModel = FibonacciViewModel()
	}

	override func tearDown() {
		super.tearDown()
		viewModel = nil
	}

	func test_fibonacciList_withZeroPositions() {
		let result = viewModel.fibonacciList(positionsQty: 0)

		XCTAssertEqual(result.count, 0)
	}

	func test_fibonacciList_withOnePosition() {
		let result = viewModel.fibonacciList(positionsQty: 1)

		XCTAssertEqual(result.count, 1)
		XCTAssertEqual(result[0], "fib(0) = 0")
	}

	func test_fibonacciList_withMultiplePositions() {
		let result = viewModel.fibonacciList(positionsQty: 8)

		XCTAssertEqual(result.count, 8)
		XCTAssertEqual(result[0], "fib(0) = 0")
		XCTAssertEqual(result[1], "fib(1) = 1")
		XCTAssertEqual(result[2], "fib(2) = 1")
		XCTAssertEqual(result[3], "fib(3) = 2")
		XCTAssertEqual(result[4], "fib(4) = 3")
		XCTAssertEqual(result[5], "fib(5) = 5")
		XCTAssertEqual(result[6], "fib(6) = 8")
		XCTAssertEqual(result[7], "fib(7) = 13")
	}

	// MARK: - Test recursiveFib

	func test_recursiveFib_withZero() {
		let result = viewModel.recursiveFib(0)
		XCTAssertEqual(result, 0)
	}

	func test_recursiveFib_withOne() {
		let result = viewModel.recursiveFib(1)
		XCTAssertEqual(result, 1)
	}

	func test_recursiveFib_with7() {
		let result = viewModel.recursiveFib(7)
		XCTAssertEqual(result, 13)
	}

	func test_recursiveFib_withLargeValues() {
		let result = viewModel.recursiveFib(10)
		XCTAssertEqual(result, 55)

		let result2 = viewModel.recursiveFib(15)
		XCTAssertEqual(result2, 610)
	}

	// MARK: - Test iterativeFib

	func test_iterativeFib_withZero() {
		let result = viewModel.iterativeFib(0)
		XCTAssertEqual(result, 0)
	}

	func test_iterativeFib_withOne() {
		let result = viewModel.iterativeFib(1)
		XCTAssertEqual(result, 1)
	}

	func test_iterativeFib_with7() {
		let result = viewModel.iterativeFib(7)
		XCTAssertEqual(result, 13)
	}

	func test_iterativeFib_withLargeValues() {
		let result = viewModel.iterativeFib(10)
		XCTAssertEqual(result, 55)

		let result2 = viewModel.iterativeFib(15)
		XCTAssertEqual(result2, 610)
	}

	// MARK: - Performance Tests

	func test_recursiveFib_performance() {
		let input = 40

		self.measure {
			let startTime = CFAbsoluteTimeGetCurrent()
			let _ = viewModel.recursiveFib(input)
			let timeTaken = CFAbsoluteTimeGetCurrent() - startTime

			XCTAssertLessThanOrEqual(timeTaken, 1.20, "Recursive Fibonacci took too long: \(timeTaken) seconds.")
		}
	}

	func test_iterativeFib_performance() {
		let input = 40

		self.measure {
			let startTime = CFAbsoluteTimeGetCurrent()
			let _ = viewModel.iterativeFib(input)
			let timeTaken = CFAbsoluteTimeGetCurrent() - startTime

			XCTAssertLessThanOrEqual(timeTaken, 0.1, "Recursive Fibonacci took too long: \(timeTaken) seconds.")
		}
	}

}
