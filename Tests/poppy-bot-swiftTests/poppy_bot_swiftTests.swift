import XCTest
@testable import PoppyBot

class poppy_bot_swiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        XCTAssertEqual(poppy_bot_swiftTests, "Hello, World!")
    }

    func testCrawler() {
        let crawler = WasedaNewsCrawler.init()
        let doc = try! crawler.fetch()
        print(doc?.body)
    }


    static var allTests = [
        ("testExample", testExample),
        ("testCrawler", testCrawler)
    ]
}
