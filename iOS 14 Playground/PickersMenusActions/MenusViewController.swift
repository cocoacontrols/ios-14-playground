//
//  MenusViewController.swift
//  iOS 14 Playground
//
//  Created by Aaron Brethorst on 6/24/20.
//

import UIKit

final class MenusViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let ellipsisImage = UIImage(systemName: "ellipsis.circle")

        let barButtonItem = UIBarButtonItem(image: ellipsisImage, style: .plain, target: nil, action: nil)
        barButtonItem.menu = buildMenu()
        navigationItem.rightBarButtonItem = barButtonItem

        let button = autolayoutNew(UIButton(type: .system)) {
            $0.menu = self.buildMenu()
            $0.showsMenuAsPrimaryAction = true
            $0.setImage(ellipsisImage, for: .normal)
        }
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func buildMenu() -> UIMenu {
        let save = UIAction(title: "Save", image: UIImage(systemName: "tray.and.arrow.down.fill"), identifier: nil) { _ in }
        let rotate = UIAction(title: "Rotate", image: UIImage(systemName: "arrow.counterclockwise"), identifier: nil) { _ in }
        let edit = UIMenu(title: "Edit", image: nil, identifier: nil, children:[rotate])
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, attributes: .destructive) { _ in }
        return UIMenu(title: "Menu", image: nil, identifier: nil, children:[save, edit, delete])
    }
}
