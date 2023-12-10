//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 10.12.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: - Layout variables
    private lazy var editButton: UIButton = {
        let imageButton = UIImage(named: "edit")
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(imageButton, for: .normal)
        button.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        
        return button
    }()
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "person"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .ypBlackDay
        label.text = "Joaquin Phoenix"
        
        return label
    }()
    private lazy var bioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 13, weight: .regular)
        textView.textColor = .ypBlackDay
        textView.text = """
                        Дизайнер из Казани, люблю цифровое искусство
                        и бейглы. В моей коллекции уже 100+ NFT,
                        и еще больше — на моём сайте.
                        Открыт к коллаборациям.
                        """
        textView.isEditable = false
        
        return textView
    }()
    private lazy var urlTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        textView.textColor = .ypBlueUniversal
        textView.text = "Joaquin Phoenix.com"
        textView.isEditable = false
        
        return textView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profileTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .ypWhiteDay
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        tableView.rowHeight = 54
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    //TODO: - Логика нажатия на ячейки
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "profileTableViewCell",
            for: indexPath
        ) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        var name = ""
        var count: Int?
        
        switch indexPath.row {
            case 0:
                name = "Мои NFT"
                count = 112
            case 1:
                name = "Избранные NFT"
                count = 11
            default:
                name = "О разработчике"
        }
        cell.configureCell(name: name, count: count)
        
        return cell
    }
}

//MARK: - Private functions
private extension ProfileViewController {
    func setupView() {
        view.backgroundColor = .ypWhiteDay
        
        addSubViews()
        configureConstraints()
    }
    
    func addSubViews() {
        view.addSubview(editButton)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(bioTextView)
        view.addSubview(urlTextView)
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bioTextView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            bioTextView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 75),
            
            urlTextView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            urlTextView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            urlTextView.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 8),
            urlTextView.heightAnchor.constraint(equalToConstant: 28),
            
            tableView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: urlTextView.bottomAnchor, constant: 40),
            tableView.heightAnchor.constraint(equalToConstant: 162)
        ])
    }
    
    @objc
    func editProfile() {
        
    }
}
