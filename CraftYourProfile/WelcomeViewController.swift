//
//  WelcomeViewController.swift
//  CraftYourProfile
//
//  Created by Дмитрий Константинов on 16.05.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    let mainLabel = UILabel(text: "Craft Your Profile", font: .compactRounded(style: .bold, size: 26), color: .white)
    let additionalLabel = UILabel(text: "Create a profile, follow other accounts, make your own lives!",
                                  font: .compactRounded(style: .medium, size: 20),
                                  color: .grayText(), lines: 2)
    let smileButton = UIButton(image: UIImage(named: "whiteSmile"))
    let letsGoButton = UIButton(title: "LET'S GO!!!",
                                titleColor: .blackText(),
                                backgroundColor: .whiteButton(),
                                font: .compactRounded(style: .bold, size: 20),
                                cornerRadius: 23)
    let bottomTextView = UITextView(text: "By signing up, you agree to our Terms and Privacy Policy",
                                couples: [("Terms", "https://developer.apple.com/terms/"),
                                          ("Privacy Policy", "https://www.apple.com/legal/privacy/en-ww/")],
                                font: .compactRounded(style: .medium, size: 16),
                                textColor: .grayText(), backgroundColor: .welcomeBlue(), tintColor: .white)

    let safariButton = UIButton(image: UIImage(named: "safari"))
    let homeButton = UIButton(image: UIImage(named: "home"))
    let circleButton = UIButton(image: UIImage(named: "circle"))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.welcomeBlue()
        setupCenterElements()
        setupBottomTextView()
        setupAnimation()
        setupBottomButtons()
    }
}

// MARK: Setup Animation
extension WelcomeViewController {

    private func setupAnimation() {

        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.height + 50)
        emitterLayer.emitterSize = CGSize(width: view.bounds.width + 50, height: 20)
        emitterLayer.emitterShape = .line
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.timeOffset = 1
        emitterLayer.birthRate = 0.3

        let emoji = ["😍", "🥰", "😘", "😜", "💋", "❤️"]
        emitterLayer.emitterCells = makeEmitterCells(emoji: emoji)

        view.layer.addSublayer(emitterLayer)
    }

    private func makeEmitterCells(emoji: [String]) -> [CAEmitterCell] {

        var cells = [CAEmitterCell]()

        for index in 0..<emoji.count*3 {

            let cell = CAEmitterCell()
            let random = .pi / 180 * Float.random(in: -20...20)
            cell.contents = emoji[index % emoji.count].emojiToImage()?.rotate(radians: random)?.cgImage
            cell.scale = 0.4
            cell.scaleRange = 0.3
            cell.birthRate = Float.random(in: 0.2...0.6)
            cell.lifetime = 8.0
            cell.velocity = 20
            cell.yAcceleration = -40
            cells.append(cell)
        }
        return cells
    }
}

// MARK: Setup Subviews
extension WelcomeViewController {

    private func setupCenterElements() {

        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        smileButton.translatesAutoresizingMaskIntoConstraints = false
        letsGoButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainLabel)
        view.addSubview(additionalLabel)
        view.addSubview(smileButton)
        view.addSubview(letsGoButton)

        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            additionalLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 6),
            additionalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            additionalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),

            smileButton.heightAnchor.constraint(equalToConstant: 70),
            smileButton.widthAnchor.constraint(equalToConstant: 70),
            smileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smileButton.bottomAnchor.constraint(equalTo: mainLabel.topAnchor, constant: -30),

            letsGoButton.topAnchor.constraint(equalTo: additionalLabel.bottomAnchor, constant: 30),
            letsGoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letsGoButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            letsGoButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    private func setupBottomTextView() {

        bottomTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomTextView)

        NSLayoutConstraint.activate([
            bottomTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            bottomTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            bottomTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            bottomTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupBottomButtons() {

        safariButton.alpha = 0.9
        circleButton.alpha = 0.9

        safariButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(safariButton)
        view.addSubview(homeButton)
        view.addSubview(circleButton)

        NSLayoutConstraint.activate([
            safariButton.heightAnchor.constraint(equalToConstant: 60),
            safariButton.widthAnchor.constraint(equalToConstant: 60),
            safariButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            safariButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),

            homeButton.heightAnchor.constraint(equalToConstant: 64),
            homeButton.widthAnchor.constraint(equalToConstant: 64),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 90),
            homeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),

            circleButton.heightAnchor.constraint(equalToConstant: 56),
            circleButton.widthAnchor.constraint(equalToConstant: 56),
            circleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -90),
            circleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45)
        ])
    }
}

// MARK: SwiftUI
import SwiftUI

struct WelcomeVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let welcomeVC = WelcomeViewController()
        // swiftlint:disable line_length
        func makeUIViewController(context: UIViewControllerRepresentableContext<WelcomeVCProvider.ContainerView>) -> WelcomeViewController {
            return welcomeVC
        }
        func updateUIViewController(_ uiViewController: WelcomeVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WelcomeVCProvider.ContainerView>) {
        }
        // swiftlint:enable line_length
    }
}
