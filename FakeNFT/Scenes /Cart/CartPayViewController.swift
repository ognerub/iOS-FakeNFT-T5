import UIKit

final class CartPayViewController: UIViewController {
    
    // MARK: - Mock properties
    private var criptoArray: [CriptoViewModel] = [
        CriptoViewModel(
            title: "BTC",
            name: "Bitcoin",
            image: UIImage.criptoBTC,
            id: "1"),
        CriptoViewModel(
            title: "DOGE",
            name: "Dogecoin",
            image: UIImage.criptoDOGE,
            id: "2"),
        CriptoViewModel(
            title: "USDT",
            name: "Tether",
            image: UIImage.criptoUSDT,
            id: "3"),
        CriptoViewModel(
            title: "APE",
            name: "Apecoin",
            image: UIImage.criptoAPE,
            id: "4"),
        CriptoViewModel(
            title: "SOL",
            name: "Solana",
            image: UIImage.criptoSOL,
            id: "5"),
        CriptoViewModel(
            title: "ETH",
            name: "Ethereum",
            image: UIImage.criptoETH,
            id: "6"),
        CriptoViewModel(
            title: "ADA",
            name: "Cardano",
            image: UIImage.criptoADA,
            id: "7"),
        CriptoViewModel  (
            title: "SHIB",
            name: "Shiba Inu",
            image: UIImage.criptoSHIB,
            id: "8"),
    ]
    
    // MARK: - Private mutable properties
    private lazy var titleBackgroundView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 88)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.backward, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = UIColor.ypBlackDay
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cartPayLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("cart.cartPayViewController.title", comment: "")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.ypBlackDay
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.ypLightGreyDay
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(),
            target: self,
            action: #selector(didTapPayButton)
        )
        button.backgroundColor = UIColor.ypBlackDay
        button.setTitle(NSLocalizedString("cart.cartPayViewController.pay", comment: ""), for: .normal)
        button.setTitleColor(UIColor.ypWhiteDay, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: - View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ypWhiteDay
        navigationController?.navigationBar.isHidden = true
        collectionViewConfig()
        configureConstraints()
        
    }
    
    private func collectionViewConfig() {
        /// Make VC a dataSource of collectionView, to config Cell
        collectionView.dataSource = self
        /// Register Cell
        collectionView.register(CartPayCollectionViewCell.self, forCellWithReuseIdentifier: CartPayCollectionViewCell().cellIdentifier)
        /// Make VC a delegate of collectionView, to config Header and Footer
        collectionView.delegate = self
        /// disable multiple selection
        collectionView.allowsMultipleSelection = false
    }
    
    // MARK: - Objective-C function
    @objc
    private func didTapPayButton() {
        print("pay button tapped")
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CollectionViewDataSource
extension CartPayViewController: UICollectionViewDataSource {
    /// Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    /// Number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return criptoArray.count
    }
    
    /// Cell for item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartPayCollectionViewCell().cellIdentifier, for: indexPath) as? CartPayCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: indexPath)
        return cell
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension CartPayViewController: UICollectionViewDelegateFlowLayout {
    /// Set layout width and height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2 - 3.5) - 16, height: 46)
    }
    /// Set layout horizontal spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    /// Set layout vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    /// Set section insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        return sectionInsets
    }
}

// MARK: - Configure constraints
private extension CartPayViewController {
    
    func configureConstraints() {
        view.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 42),
            backButton.widthAnchor.constraint(equalToConstant: 42),
            backButton.leadingAnchor.constraint(equalTo: titleBackgroundView.leadingAnchor),
            backButton.bottomAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor)
        ])
        titleBackgroundView.addSubview(cartPayLabel)
        NSLayoutConstraint.activate([
            cartPayLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            cartPayLabel.leadingAnchor.constraint(equalTo: titleBackgroundView.leadingAnchor),
            cartPayLabel.trailingAnchor.constraint(equalTo: titleBackgroundView.trailingAnchor)
        ])
        
        view.addSubview(bottomBackgroundView)
        NSLayoutConstraint.activate([
            bottomBackgroundView.heightAnchor.constraint(equalToConstant: 186),
            bottomBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        bottomBackgroundView.addSubview(payButton)
        NSLayoutConstraint.activate([
            payButton.heightAnchor.constraint(equalToConstant: 60),
            payButton.leadingAnchor.constraint(equalTo: bottomBackgroundView.leadingAnchor, constant: 12),
            payButton.trailingAnchor.constraint(equalTo: bottomBackgroundView.trailingAnchor, constant: -12),
            payButton.bottomAnchor.constraint(equalTo: bottomBackgroundView.bottomAnchor, constant: -50)
        ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomBackgroundView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

