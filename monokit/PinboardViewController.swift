//
//  PinboardController.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import UIKit
import Pinboard
import RxSwift
import Lib
import APIKit

class PinboardViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var apiTokenLabel: UILabel!
    @IBOutlet private weak var urlTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("pinboard.title", comment: "")
        userTextField.text = PinboardService.shared.user
        self.updateApiTokenLabel(token: PinboardService.shared.apiToken)
    }

    @IBAction func authenticateDidTap(_ sender: UIButton) {
        Lib.Progress.show()
        PinboardService.shared.authenticate(user: userTextField.text!, password: passwordTextField.text!)
            .subscribe { [unowned self] event in
                switch event {
                case .error(let error):
                    Lib.Progress.error(error)
                case .completed:
                    break
                case .next(let token):
                    logger.debug("token: \(token)")
                    self.updateApiTokenLabel(token: token)
                    Lib.Progress.success()
                }
        }
        .addDisposableTo(disposeBag)
    }

    @IBAction func postDidTap(_ sender: UIButton) {
        guard let text = urlTextField.text, !text.isEmpty else {
            Lib.Progress.error(status: NSLocalizedString("pinbaord.url_empty", comment: ""))
            return
        }
        PinboardService.shared.post(url: URL(string: text)!, tags: [PinboardTag.star🌟.rawValue])
            .subscribe { [unowned self] event in
                switch event {
                case .error(let error):
                    Lib.Progress.error(error)
                case .completed:
                    break
                case .next(let code):
                    logger.debug("code: \(code)")
                    Lib.Progress.success()
                }
            }
            .addDisposableTo(disposeBag)
    }

    private func updateApiTokenLabel(token: String?) {
        guard let token = token else {
            return
        }
        let n = token.count - 3
        apiTokenLabel.text = token.dropLast(n) + String(repeating: "*", count: n)
    }
}
