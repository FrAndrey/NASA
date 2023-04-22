//
//  NASATests.swift
//  NASATests
//
//  Created by Administrator on 2023-04-21.
//

import XCTest
@testable import NASA

final class NASATests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageViewModel() throws {
        let image = Image(hyperlink: "https://news.ycombinator.com/", description: "M", title: "News")
        let imageViewModel = ImageViewModel(image: image)
        
        XCTAssertNotNil(imageViewModel.hyperlink)
        XCTAssertNotNil(imageViewModel.title)
        XCTAssertNotNil(imageViewModel.description)
        
        XCTAssertEqual(image.hyperlink, imageViewModel.hyperlink)
        XCTAssertEqual(image.description, imageViewModel.description)
        XCTAssertEqual(image.title, imageViewModel.title)
        
    }

}
