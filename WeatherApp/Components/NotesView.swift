//
//  NotesView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 05/11/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class NotesView: UICollectionViewCell {
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    let notesTextView = UITextView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        setupTitleLabel()
        setupTextview()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupTitleLabel() {
        titleLabel.text = "Notes"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: Padding.f25)
    }
    
    private func setupTextview() {
        notesTextView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        notesTextView.adjustsFontForContentSizeCategory = true
        notesTextView.isSelectable = true
        notesTextView.isEditable = true
        notesTextView.layer.cornerRadius = Padding.f10
        notesTextView.font = UIFont.systemFont(ofSize: Padding.f20)
        notesTextView.textColor = .white
        notesTextView.layer.borderColor = UIColor.white.cgColor
        notesTextView.layer.borderWidth = 1
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(notesTextView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f5)
            $0.centerX.equalToSuperview()
        }
        
        notesTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f10)
            $0.leading.equalToSuperview().offset(Padding.f15)
            $0.trailing.equalToSuperview().offset(-Padding.f15)
            $0.bottom.equalToSuperview().offset(-Padding.f15)
        }
    }
}
