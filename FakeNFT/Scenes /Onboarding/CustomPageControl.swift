import UIKit

protocol CustomPageControlProtocol: AnyObject {
    func send(currentPage: Int)
}

final class CustomPageControl: UIPageControl {
    
    weak var delegate: CustomPageControlProtocol?
    
    private let buttonHeight: CGFloat = 4.0
    private let buttonLeading: CGFloat = 16.0
    private let buttonSpacing: CGFloat = 8.0
    
    override var numberOfPages: Int {
        didSet {
            setupButtons()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateButtonSelection()
        }
    }
    
    private var buttons: [UIButton] = []
    private var buttonsViews: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        for _ in 0 ..< numberOfPages {
            let button = UIButton()
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
            let buttonView = UIView()
            buttonView.backgroundColor = UIColor.ypWhiteUniversal
            buttonView.layer.cornerRadius = 2
            buttonsViews.append(buttonView)
            button.insertSubview(buttonView, at: 0)
            
        }
        updateButtonLayout()
        updateButtonSelection()
    }
    
    private func updateButtonLayout() {
        
        let buttonAutomaticWidth = (frame.width - (buttonLeading * 2) - (buttonSpacing * CGFloat(max(0, numberOfPages - 1)))) / CGFloat(numberOfPages)
        
        var totalWidth: CGFloat = CGFloat(numberOfPages) * buttonAutomaticWidth + CGFloat(max(0, numberOfPages - 1)) * buttonSpacing
        
        if let lastButton = buttons.last {
            totalWidth += lastButton.frame.width
        }
        
        let startX = buttonLeading
        
        for (index, button) in buttons.enumerated() {
            let x = startX + CGFloat(index) * (buttonAutomaticWidth + buttonSpacing)
            
            button.frame = CGRect(x: x, y: 0, width: buttonAutomaticWidth, height: frame.height)
            
            buttonsViews[index].frame = CGRect(x: 0, y: button.frame.height/2 - buttonHeight/2, width: button.frame.width, height: buttonHeight)
            
            buttonsViews[index].isUserInteractionEnabled = false
        }
    }
    
    private func updateButtonSelection() {
        for (index, buttonViews) in buttonsViews.enumerated() {
            buttonViews.backgroundColor = (index == currentPage) ? UIColor.ypWhiteUniversal : UIColor.ypLightGreyDay
        }
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        if let index = buttons.firstIndex(of: sender) {
            currentPage = index
            delegate?.send(currentPage: currentPage)
            sendActions(for: .valueChanged)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButtonLayout()
        updateButtonSelection()
    }
}