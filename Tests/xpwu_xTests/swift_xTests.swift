import XCTest
@testable import xpwu_x

final class swift_xTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
	
	func testLogger() {
		let logger = PrintLogger()
		logger.Debug("ddd", "xxx")
	}
	
	func testDurationToString() throws {
		_ = [
			(5*Duration.Second + 13*Duration.Hour + 9*Duration.Minute + 380*Duration.Millisecond + 40*Duration.Microsecond,
			"13h9min5s380ms40us"),
			(300*Duration.Second, "5min"),
			(30*Duration.Second, "30s"),
			(0, "0us"),
		].map { testValue in
			let (t, s) = testValue
			XCTAssertEqual(t.toString, s)
		}
	}
	
	func testDurationfrom() throws {
		_ = [
			(5*Duration.Second + 13*Duration.Hour + 9*Duration.Minute + 380*Duration.Millisecond + 40*Duration.Microsecond,
			"13h9min5s380ms40us"),
			(300*Duration.Second, "5min"),
			(30*Duration.Second, "30s"),
			(nil, "30ss"),
			(0, "0us"),
			(0, "0s"),
			(0, "0000h00min000s0ms00000us"),
		].map { testValue in
			let (t, s) = testValue
			let d = Duration.from(string: s)
			XCTAssertEqual(t, d)
		}
	}
}
