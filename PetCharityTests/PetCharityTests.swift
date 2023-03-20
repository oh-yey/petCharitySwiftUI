//
//  PetCharityTests.swift
//  PetCharityTests
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import XCTest

@testable import PetCharity

final class PetCharityTests: XCTestCase {

    override func setUpWithError() throws {
        print("开始测试")
    }

    override func tearDownWithError() throws {
            print("测试结束")
    }

    func testData() {
        let sut = data2String(Date())
        XCTAssertEqual(sut, "2023-03-10")
    }

}
