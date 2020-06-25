//
//  Helpers.swift
//  iOS 14 Playground
//
//  Created by Aaron Brethorst on 6/25/20.
//

import UIKit

// MARK: - Auto Layout

// Adapted from https://www.swiftbysundell.com/articles/writing-small-utility-functions-in-swift/

func autolayoutNew<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T where T: UIView {
    value.translatesAutoresizingMaskIntoConstraints = false
    var value = value
    try closure(&value)
    return value
}

// MARK: - UIStackView

extension UIStackView {
    static func vertical(_ arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16.0
        stack.axis = .vertical
        return stack
    }

    static func horizontal(_ arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16.0
        stack.axis = .horizontal
        return stack
    }
}
