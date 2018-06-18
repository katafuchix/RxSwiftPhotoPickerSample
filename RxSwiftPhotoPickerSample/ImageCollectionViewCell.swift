//
//  ImageCollectionViewCell.swift
//  PickerRxSample
//
//  Created by cano on 2018/06/18.
//  Copyright © 2018年 sample. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TLPhotoPicker

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    func setAsset(_ asset: TLPHAsset) {
        if let image = asset.fullResolutionImage {
            self.imageView.image = image
        }
    }
}
