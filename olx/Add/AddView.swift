//
//  AddView.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 24/10/26.
//

import UIKit
import SnapKit

class AddView: UIView {
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.keyboardDismissMode = .interactive
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .red
    }
    
    let addAboutText = UILabel().then {
        $0.text = "Расскажите нам о вашей рекламе"
        $0.textColor = ColorResourceManager.shared.primaryText
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    let imageFrame = UIView().then {
        $0.backgroundColor = ColorResourceManager.shared.addImgBackground
    }
    
    let imageAddText = UILabel().then {
        $0.text = "Добавьте изображение"
        $0.textColor = ColorResourceManager.shared.primaryText
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddView {
    func setupUI () {
        backgroundColor = ColorResourceManager.shared.appBackground
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews([
            addAboutText,
            imageFrame,
            imageAddText
        ])
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
        }
        
        addAboutText.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        imageFrame.snp.makeConstraints {
            $0.top.equalTo(addAboutText.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(200)
        }
        
        imageAddText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(imageFrame.snp.bottom).offset(-20)
        }
    }
}
