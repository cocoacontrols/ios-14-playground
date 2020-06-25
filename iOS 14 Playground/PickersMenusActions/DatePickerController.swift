//
//  DatePickerController.swift
//  iOS 14 Playground
//
//  Created by Aaron Brethorst on 6/25/20.
//

import UIKit

final class DatePickerController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Date Picker"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Get Date", style: .plain, target: self, action: #selector(getDate))

        view.addSubview(datePicker)

        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()

    @objc func getDate() {
        let date = datePicker.date
        let alert = UIAlertController(title: "Date Selected", message: String(describing: date), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
