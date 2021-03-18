//
//  FullNewsView.swift
//  pecodeNewsApplication
//
//  Created by mozeX on 17.03.2021.
//


import UIKit


// MARK: - Protocols
protocol CloseViewDelegate: class {
    func closeFullViewButtonClicked(sender: UIButton)
}



class FullNewsView: UIView {

    // MARK: - Public
    weak var delegate: CloseViewDelegate?
    public var newsDescription = ""
    public var imageURL = ""
    
    public let newsTextLabel: UILabel = {
     let label = UILabel()
     label.textColor = .black
     label.textAlignment = .natural
     label.contentMode = .scaleToFill
     label.translatesAutoresizingMaskIntoConstraints = false
     label.numberOfLines = 0
     label.isUserInteractionEnabled = true
     return label
     }()
    
    
    // MARK: - Private
    private let newsImage : UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleToFill
    imgView.clipsToBounds = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
    }()
    
    
    private let closeButton: UIButton = {
     let button = UIButton()
     button.setTitle("Close", for: .normal)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.backgroundColor = .red
     button.addTarget(self, action: #selector(closeFullViewButtonClicked(sender:)), for: .touchUpInside)
     return button
     }()
    
   
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods
    private func setupView() {
        addSubview(newsImage)
        addSubview(newsTextLabel)
        self.newsTextLabel.addSubview(closeButton)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.newsTextLabel.text = newsDescription
        

        NSLayoutConstraint .activate([
        
            newsImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            newsImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            newsImage.topAnchor.constraint(equalTo: self.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: newsTextLabel.topAnchor),
            newsImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            newsTextLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            newsTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            newsTextLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            newsTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            newsTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            closeButton.bottomAnchor.constraint(equalTo: newsTextLabel.bottomAnchor),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
 
        ])

    }
    
    
    // MARK: - Public methods
   func showImage(from url: String) {
        getImage(from: url, to: newsImage)
    }
    
    
    
    // MARK: - Delegate method
    @objc func closeFullViewButtonClicked(sender: UIButton) {
        delegate?.closeFullViewButtonClicked(sender: sender)
    }
    
    
}

