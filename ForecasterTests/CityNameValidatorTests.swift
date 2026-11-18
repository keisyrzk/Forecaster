//
//  CityNameValidatorTests.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import Testing
@testable import Forecaster

struct CityNameValidatorTests {
    @Test(
        "Accept valid city names",
        arguments: ["Łódź", "New York", "Bielsko-Biała", "  Nowy Sącz"]
    )
    func acceptValidNames(input: String) {
        let validator = CityNameValidator()

        #expect(validator.isValid(for: input))
    }

    @Test(
        "Reject invalid city names",
        arguments: [
            "",
            "   ",
            "ab",
            " ab ",
            "---",
            "Paris123",
            "Paris!"
        ]
    )
    func rejectInvalidNames(input: String) {
        let validator = CityNameValidator()

        #expect(!validator.isValid(for: input))
    }
}
