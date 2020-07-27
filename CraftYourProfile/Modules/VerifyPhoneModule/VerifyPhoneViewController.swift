//
//  VerifyPhoneViewController.swift
//  CraftYourProfile
//
//  Created by Дмитрий Константинов on 27.05.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: UIViewController {

    // MARK: - Properties
    var modelController: VerifyPhoneModelControllerProtocol?
    private var presentationView: VerifyPhoneView?

    lazy private var countryCodeViewController: CountryCodeViewController = {
        let viewController = CountryCodeViewController()
        viewController.delegate = self
        return viewController
    }()

    // MARK: - Lifecycle
    override func loadView() {
        let view = VerifyPhoneView()
        view.delegate = self
        self.presentationView = view
        self.view = ScrollViewContainer(with: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("start load network data")
        let countryCode = Locale.current.regionCode
        print(countryCode)
//        guard let current = modelController?.getCountryCodes(with: nil).filter { $0.shortName == countryCode }.first else { return }
//        presentationView?.setCountryCode(string: current.code)
    }
}

// MARK: VerifyPhoneViewDelegate
extension VerifyPhoneViewController: VerifyPhoneViewDelegate {

    func shouldChangeCharactersIn(_ textField: UITextField, string: String) -> Bool {

        if string.isEmpty {
            textField.text?.removeAll { $0 == "-" }
            return true
        }
        if Int(string) == nil { return false }
        if modelController?.isValid(phone: textField.text, completion: { _ in }) == true {
            return false
        }

        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if modelController?.isValid(phone: text, completion: { _ in }) == true {
            let formattedPhone = modelController?.getFormattedPhoneNumber(phone: text) { [weak self] (error) in
                guard let error = error else { return }
                self?.showAlert(with: "Phone Number Formatting Error", and: error.localizedDescription)
            }
            textField.text = formattedPhone
        }
    }

    func crossButtonTapped() {
        dismiss(animated: true)
    }

    func codeButtonTapped(_ view: UIView) {
        modelController?.networkErrorChecking { [weak self] (error) in
            guard let error = error else { return }
            showAlert(with: "Network Error", and: error.localizedDescription) {
                self?.modelController?.reloadData()
            }
        }
        present(countryCodeViewController, animated: true)
    }

    func nextButtonTapped(string: String?) {

        guard let string = string else { return }

        if modelController?.isValid(phone: string, completion: { [weak self] (error) in
            guard let error = error else { return }
            self?.showAlert(with: "Validation Error", and: error.localizedDescription)
        }) == true {
            let pinCode = AuthorizationService.shared.generationPinCode(with: 6)
            do {
                try AuthorizationService.shared.signIn(account: string, pinCode: pinCode)
            } catch let error {
                showAlert(with: "Keychain Error", and: error.localizedDescription)
                return
            }
            showAlert(with: "Success", and: "A PIN code \(pinCode) has been sent to your phone number") {
                let viewController = ViewControllerFactory().makeVerifyPinCodeViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            showAlert(with: "Error", and: "Unable to complete validation procedure")
        }
    }
}

// MARK: CountryCodeViewControllerDelegate
extension VerifyPhoneViewController: CountryCodeViewControllerDelegate {

    func getCountryCodes(with filter: String?) -> [CountryCode] {
        return modelController?.getCountryCodes(with: filter) ?? []
    }

    func didSelectItemAt(index: Int) {
        let code = modelController?.getTheSelectedCode(at: index) ?? ""
        presentationView?.setCountryCode(string: code)
    }
}
