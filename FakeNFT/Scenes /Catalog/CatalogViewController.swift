//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Iurii on 09.12.23.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    //MARK: - Layout variables
    
    private lazy var sortingButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "Sort")
        button.setImage(image, for: .normal)
        button.addTarget(
            self,
            action: #selector(didTapSortingButton),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 179
        tableView.layer.cornerRadius = 12
        tableView.backgroundColor = .ypWhiteDay
        tableView.register(CatalogCell.self, forCellReuseIdentifier: CatalogCell.reuseIdentifier)
        //        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        addSubViews()
        applyConstraints()
    }
    
    // MARK: - IBAction
    
    @objc
    private func didTapSortingButton() {
        
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        [sortingButton, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            sortingButton.heightAnchor.constraint(equalToConstant: 42),
            sortingButton.heightAnchor.constraint(equalToConstant: 42),
            sortingButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 324),
            sortingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            sortingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -9),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: sortingButton.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource

extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatalogCell.reuseIdentifier, for: indexPath)
        
        guard let catalogCell = cell as? CatalogCell else {
            return UITableViewCell()
        }
        
        catalogCell.configureCell()
        
        return catalogCell
    }
}
