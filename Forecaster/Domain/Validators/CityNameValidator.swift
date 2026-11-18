//
//  CityNameValidator.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

import Foundation

nonisolated struct CityNameValidator: Validator {

    func isValid(for input: String) -> Bool {
        return isValidForSearch(input)
    }
    
    private func containsOnlyAllowedCharacters(_ input: String) -> Bool {
        input.allSatisfy { character in
            character.isLetter
            || character == " "
            || character == "-"
        }
    }

    /// Check if all satisfied:
    /// - input contains at least 3 characters
    /// - at least one character is a letter
    /// - all characters in the given input are letters, whitespace or "-"
    private func isValidForSearch(_ input: String) -> Bool {
        let query = input.trimmingCharacters(in: .whitespacesAndNewlines)

        return query.count >= 3
            && query.contains(where: \.isLetter)
            && containsOnlyAllowedCharacters(query)
    }
}
