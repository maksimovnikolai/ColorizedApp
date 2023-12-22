//
//  ColorViewController.swift
//  Colorized
//
//  Created by Nikolai Maksimov on 22.12.2023.
//

import UIKit

final class ColorViewController: UIViewController {
    
    private var colorView = ColorView()
    
    override func loadView() {
        view = colorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}
