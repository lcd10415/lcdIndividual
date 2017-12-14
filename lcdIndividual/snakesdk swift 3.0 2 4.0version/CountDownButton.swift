import UIKit

class CountdownButton: UIButton {
    
    // MARK: Properties
    
    var maxSecond = 60
    var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    
    private var _second = 0
    private var _timer: Timer?
    
    private var _lblTime: UILabel!
    
    private var _normalTitle: String!
    private var _normalColor: UIColor!
    
    private var _disabledTitle: String!
    private var _disabledColor: UIColor!
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()

    }
    
    deinit {
        countdown = false
    }
    
    // MARK: Setups
    
    private func setupLabel() {
        _normalTitle = title(for: .normal)!
        _disabledTitle = title(for: .disabled)!
        
        _normalColor = titleColor(for: .normal)!
        _disabledColor = titleColor(for: .disabled)!
        
     //   print
        
        setTitle("", for: .normal)
        setTitle("", for: .disabled)
        
        _lblTime = UILabel(frame: bounds)
        
        _lblTime.textAlignment = .center
        _lblTime.backgroundColor = Meta.selectedBgColor
        
        _lblTime.textColor = _normalColor
        _lblTime.text = _normalTitle
        
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(_lblTime)
    }
    override func layoutSubviews() {
        _lblTime.frame = bounds
        _lblTime.font = titleLabel?.font
    }
    
    // MARK: Private
    
    private func startCountdown() {
        _second = maxSecond
        updateDisabled()
        
        if _timer != nil {
            _timer!.invalidate()
            _timer = nil
        }
        
        _timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        _timer?.invalidate()
        _timer = nil
        updateNormal()
    }
    
    private func updateNormal() {
        isEnabled = true
        _lblTime.textColor = _normalColor
        _lblTime.text = _normalTitle
    }
    
    private func updateDisabled() {
        isEnabled = false
        _lblTime.textColor = _disabledColor
        _lblTime.text = "\(_second)s"
       }
    
    @objc private func updateCountdown() {
        _second -= 1
        if _second <= 0 {
            countdown = false
            _lblTime.text = "reObtain".localized
        } else {
            updateDisabled()
        }
    }
    
    
}
