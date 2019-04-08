//
//  FeedPublishViewController.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FeedPublishViewController: UIViewController {
    
    @IBOutlet weak var sendBarButton: UIBarButtonItem!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var buttonBarBottomConstraint: NSLayoutConstraint!
    
    var viewModel: FeedPublishViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
        setupObservable()
    }
    
    private func setupViews() {
        inputTextView.becomeFirstResponder()
        
        avatarImage.sd_setImage(with: viewModel.avatarUrl,
                                placeholderImage: UIImage(named: "avatar"))
    }
    
    private func setupViewModel() {
        viewModel.sendBarButtonEnable
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: sendBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.username
            .asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: usernameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.message
            .asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .map { $0 != "" }
            .bind(to: placeholderLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.publishResult
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] success in
                if !success {
                    print("sign in failed")
                } else {
                    _ = self?.navigationController?.popViewController(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupObservable() {
        inputTextView
            .rx.text.orEmpty
            .skip(1)
            .bind(to: viewModel.message)
            .disposed(by: disposeBag)
        
        sendBarButton
            .rx.tap
            .subscribe { [weak self] _ in
                self?.viewModel.publishFeed()
            }
            .disposed(by: disposeBag)
        
        photoLibraryButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        
        let imageObservable = photoLibraryButton
            .rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                    }
                    .flatMap { $0.rx.didFinishPickingMediaWithInfo }
            }
            .map { info in
                return info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
            }
            .share(replay: 1, scope: .whileConnected)
        
        imageObservable
            .bind(to: previewImage.rx.image)
            .disposed(by: disposeBag)
        
        imageObservable
            .map { ($0?.pngData())?.base64EncodedString() ?? "" }
            .bind(to: viewModel.image)
            .disposed(by: disposeBag)
        
        NotificationCenter.default
            .rx.notification(UIResponder.keyboardWillShowNotification)
            .map { notification -> CGRect? in
                let rectValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                return rectValue?.cgRectValue
            }
            .subscribe(onNext: { [weak self] size in
                guard let `self` = self else { return }
                let height = size == nil ? 0 : size!.height
                self.buttonBarBottomConstraint.constant = height - (UIScreen.main.bounds.height - self.view.frame.size.height)
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default
            .rx.notification(UIResponder.keyboardWillHideNotification)
            .map { notification -> CGRect? in
                let rectValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                return rectValue?.cgRectValue
            }
            .subscribe(onNext: { [weak self] _ in
                self?.buttonBarBottomConstraint.constant = 0
            })
            .disposed(by: disposeBag)
    }
    
}
