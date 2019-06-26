//
//  UIImageViewExtension.swift
//  rumi
//
//  Created by Rafael on 6/25/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import Foundation
import UIKit
import os

extension UIImageView {
    func setImage(fromAsset assetName: String?) {
        if let name = assetName {
            DispatchQueue.main.async {
                self.image = UIImage(named: name)
            }
        }
}

}
