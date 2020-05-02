//
//  FudaScreenTest.swift
//  WhatsNextScreenTests
//
//  Created by Yoshifumi Sato on 2020/05/01.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import XCTest
@testable import WhatsNextScreen

class FudaScreenTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initialScreen() {
        // given
        let sampleStr = "けふここのへににおひぬるかな"
        let sampleTitle = "サンプルのタイトル"
        let screen = FudaViewController(shimoString: sampleStr, title: sampleTitle)
        // when
        screen.loadViewIfNeeded()
        // then
        XCTAssertEqual(screen.shimoString, sampleStr)
        XCTAssertEqual(screen.title, sampleTitle)
        XCTAssertNotNil(screen.tatamiView)
        XCTAssertNotNil(screen.greenBackView)
        XCTAssertNotNil(screen.whiteBackView)
        XCTAssertEqual(screen.labels15.first?.textColor, UIColor.black)
    }

    
}
