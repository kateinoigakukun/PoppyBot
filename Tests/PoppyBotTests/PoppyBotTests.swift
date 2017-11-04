import XCTest
@testable import PoppyBot

class PoppyBotTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testWasedaCrawler() throws {
        let crawler = WasedaNewsCrawler.init()
        _ = try crawler.fetchNewItems()
    }

    func testSportsMagicCrawler() throws {
        let crawler = SportsMagicCrawler.init()
        _ = crawler.fetchNewItems()
    }


    static var allTests = [
        ("testExample", testWasedaCrawler),
        ("testCrawler", testSportsMagicCrawler)
    ]
}
