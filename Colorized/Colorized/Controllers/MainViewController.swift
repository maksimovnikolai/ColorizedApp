//
//  MainViewController.swift
//  Colorized
//
//  Created by Nikolai Maksimov on 23.12.2023.
//

import UIKit

protocol ColorViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
}

// MARK: Metods
extension MainViewController {
    private func commonInit() {
        view.backgroundColor = .lightGray
        addBarButtonItem()
    }
    
    private func addBarButtonItem() {
        let item = UIBarButtonItem(title: nil, image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                                 target: self,
                                 action: #selector(showColorViewController))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc
    private func showColorViewController() {
        let colorViewController = ColorViewController()
        colorViewController.viewColor = view.backgroundColor
        colorViewController.delegate = self
        navigationController?.pushViewController(colorViewController, animated: true)
    }
}

// MARK: ColorViewControllerDelegate
extension MainViewController: ColorViewControllerDelegate {
    
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
