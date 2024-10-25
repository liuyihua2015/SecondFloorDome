//
//  NewViewController.swift
//  xiyaSwift
//
//  Created by liuyihua on 2024/10/24.
//

import UIKit

class NewViewController: UIViewController {
    var panGesture: UIPanGestureRecognizer!
    var initialTouchPoint: CGPoint = .init(x: 0, y: 0)
    let dismissButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red // 设置背景色

        // 添加左滑手势
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)

        // 添加按钮
        setupDismissButton()
    }

    // 设置按钮
    func setupDismissButton() {
        dismissButton.setTitle("消失", for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.backgroundColor = .systemBlue
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
        performDismissalAnimation()
    }

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: view.window)

        switch gesture.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            let distance = touchPoint.x - initialTouchPoint.x
            if distance > 0 {
                let verticalTranslation = distance * (UIScreen.main.bounds.height / UIScreen.main.bounds.width) * 1.5
                view.transform = CGAffineTransform(translationX: 0, y: -verticalTranslation)
            }
        case .ended, .cancelled:
            let distance = touchPoint.x - initialTouchPoint.x
            if distance > UIScreen.main.bounds.width * 0.5 {
                performDismissalAnimation()
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.transform = .identity
                })
            }
        default:
            break
        }
    }

    // 执行上滑消失动画
    func performDismissalAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}
