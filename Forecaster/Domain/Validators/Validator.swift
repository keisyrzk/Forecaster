//
//  Validator.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

protocol Validator {
    func isValid(for input: String) -> Bool
}

enum ValidatorType {
    case cityName
    
    var validator: Validator {
        switch self {
        case .cityName:
            return CityNameValidator()
        }
    }
}

extension String {
    
    /// Check all given validators and return whether the input String satisfies all conditions or not
    func isValid(for validators: [ValidatorType]) -> Bool {
        return validators.allSatisfy {
            $0.validator.isValid(for: self)
        }
    }
}
