//
//  ViewController.swift
//  SecondFloorDome
//
//  Created by liuyihua on 2024/10/25.
//

import UIKit

class ViewController: UIViewController {
    let dismissButton = UIButton()
    let slideTransitionDelegate = SlideInTransitionDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 添加按钮
        setupDismissButton()
    }

    // 设置按钮
    func setupDismissButton() {
        dismissButton.setTitle("开启", for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.backgroundColor = .systemCyan
        dismissButton.layer.cornerRadius = 8
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)

        view.addSubview(dismissButton)

        // 设置按钮约束
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            dismissButton.widthAnchor.constraint(equalToConstant: 100),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // 按钮点击事件
    @objc func dismissButtonTapped() {
        let newVC = NewViewController()
        newVC.transitioningDelegate = slideTransitionDelegate
        newVC.modalPresentationStyle = .custom
        present(newVC, animated: true) {
            
        }
    }
}
