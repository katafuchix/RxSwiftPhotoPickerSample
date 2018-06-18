//
//  ViewController.swift
//  RxSwiftPhotoPickerSample
//
//  Created by cano on 2018/06/19.
//  Copyright © 2018年 sample. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TLPhotoPicker

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!

    let viewModel = ImageViewModel()
    let disposeBag = DisposeBag()
    let enabledColor = UIColor.black
    let disabledColor = UIColor.lightGray

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.bind()
    }

    func bind() {
        self.rightBarButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                let controller = TLPhotosPickerViewController(withTLPHAssets: { [weak self] assets in
                    self?.viewModel.selectedAssets.value = assets
                    }, didCancel: nil)
                controller.selectedAssets = (self?.viewModel.selectedAssets.value)! 
                var config = TLPhotosPickerConfigure()
                config.allowedVideo = false
                config.allowedLivePhotos = false
                config.cameraIcon = UIImage(named: "camera")
                config.cameraBgColor = UIColor(white: 0.9523, alpha: 1)
                controller.configure = config
                self?.present(controller, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        self.viewModel.selectedAssets.asObservable().bind(to:self.collectionView.rx.items(cellIdentifier: "ImageCollectionViewCell", cellType: ImageCollectionViewCell.self))
            { (index, element, cell) in
                cell.setAsset(element)
            }.disposed(by: disposeBag)

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        viewModel.isNextButtonEnabled.asObservable().subscribe(onNext:{ [weak self] enabled in
            self?.nextButton.backgroundColor = enabled ? self?.enabledColor : self?.disabledColor
            self?.nextButton.isEnabled = enabled
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    //セルの間の余白設定
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

    //セルのサイズを指定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (self.collectionView.frame.width - 10.0*4)/3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}



