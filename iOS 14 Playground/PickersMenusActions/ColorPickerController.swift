//
//  ColorPickerController.swift
//  iOS 14 Playground
//
//  Created by Aaron Brethorst on 6/25/20.
//

import UIKit

final class ColorPickerController: UIViewController, UIColorPickerViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color Picker"
        view.backgroundColor = .systemBackground


        if outerStackView.superview == nil {
            view.addSubview(outerStackView)
            NSLayoutConstraint.activate([
                outerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                outerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }

    // MARK: - Controls

    lazy var outerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [switchStack, showButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16.0
        stack.axis = .vertical
        return stack
    }()

    lazy var switchStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [alphaLabel, alphaSwitch])
        stack.spacing = 16.0
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var alphaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Picker supports alpha"
        return label
    }()

    lazy var showButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Color Picker", for: .normal)
        button.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        return button
    }()

    // MARK: - Switch

    lazy var alphaSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.isOn = true
        s.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        return s
    }()

    @objc func switchToggled() {
        colorPicker.supportsAlpha = alphaSwitch.isOn
    }

    // MARK: - Color Picker

    @objc func showColorPicker() {
        present(colorPicker, animated: true, completion: nil)
    }

    lazy var colorPicker: UIColorPickerViewController = {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = alphaSwitch.isOn
        picker.delegate = self
        return picker
    }()

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
    }
}
