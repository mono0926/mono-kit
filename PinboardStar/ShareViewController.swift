//
//  ShareViewController.swift
//  PinboardStar
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import UIKit
import Lib
import Pinboard
import RxSwift

class ShareViewController: UIViewController, PinboardExtension {
    @IBOutlet weak var statusLabel: UILabel!
    let disposeBag = DisposeBag()
    var tags: [PinboardTag] { return [PinboardTag.star🌟] }

    override func viewDidLoad() {
        super.viewDidLoad()
        shareToPinboard()
    }
}

