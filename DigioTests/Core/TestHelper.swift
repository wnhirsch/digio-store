//
//  TestHelper.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 04/08/2024.
//

import Foundation
import XCTest
@testable import Digio

// swiftlint:disable:next convenience_type
class TestHelper {
    
    static func loadJSONFromFile<T: Codable>(type: T.Type, filename: String) -> T? {
        guard let url = Bundle(for: self).url(forResource: filename, withExtension: "json") else {
            XCTFail("Missing file: \(filename).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            XCTFail("Error parsing \(filename).json: \(error)")
            return nil
        }
    }
}
