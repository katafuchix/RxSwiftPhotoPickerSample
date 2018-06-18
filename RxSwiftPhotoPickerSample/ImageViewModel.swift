//
//  ImageViewModel.swift
//  PickerRxSample
//
//  Created by cano on 2018/06/18.
//  Copyright © 2018年 sample. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import TLPhotoPicker

class ImageViewModel {

    // Input Sources
    let selectedAssets = Variable<[TLPHAsset]>([])
    let sendTrigger = PublishSubject<Void>()

    // Output Sources
    let isNextButtonEnabled: Observable<Bool>

    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        self.isNextButtonEnabled = self.selectedAssets.asObservable().map { $0.count > 0 }
        self.sendTrigger
            //.observeOn(MainScheduler.instance)
            .subscribe(onNext: { val in
                print("API call")
            })
            .disposed(by: disposeBag)

    }
}
