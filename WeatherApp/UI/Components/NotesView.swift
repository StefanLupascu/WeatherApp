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
    
    let notesTextView = UITextView()
    
    private let titleLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        setupTitleLabel()
        setupTextview()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p5)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.text = "Notes"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    private func setupTextview() {
        addSubview(notesTextView)
        notesTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p15)
            $0.trailing.equalToSuperview().offset(-Padding.p15)
            $0.bottom.equalToSuperview().offset(-Padding.p15)
        }
        
        notesTextView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        notesTextView.adjustsFontForContentSizeCategory = true
        notesTextView.isSelectable = true
        notesTextView.isEditable = true
        notesTextView.layer.cornerRadius = Height.h10
        notesTextView.font = UIFont.systemFont(ofSize: 20)
        notesTextView.textColor = .white
        notesTextView.layer.borderColor = UIColor.white.cgColor
        notesTextView.layer.borderWidth = Height.h1
    }
}
