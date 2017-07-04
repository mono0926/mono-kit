//
//  ShareViewController.swift
//  TumblrLink
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import UIKit
import Social
import Tumblr
import RxSwift

class ShareViewController: UIViewController, TumblrExtension {
    @IBOutlet weak var statusLabel: UILabel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        shareToPinboard()
    }
}
