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

    lazy var outerStackView = UIStackView.vertical([switchStack, showButton])

    lazy var switchStack = UIStackView.horizontal([alphaLabel, alphaSwitch])

    lazy var showButton = autolayoutNew(UIButton(type: .system)) {
        $0.setTitle("Show Color Picker", for: .normal)
        $0.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
    }

    // MARK: - Alpha Switch

    lazy var alphaSwitch = autolayoutNew(UISwitch()) {
        $0.isOn = true
        $0.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
    }

    lazy var alphaLabel = autolayoutNew(UILabel()) {
        $0.text = "Picker supports alpha"
    }

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
