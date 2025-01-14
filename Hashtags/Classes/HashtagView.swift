//
//  HashtagView.swift
//  Hashtags
//
//  Created by Oscar Götting on 6/6/18.
//  Copyright © 2018 Oscar Götting. All rights reserved.
//
import UIKit
import AlignedCollectionViewFlowLayout



// MARK: Class
@IBDesignable
open class HashtagView: UIView {
    
    public struct TagStyle {
        public var selectedBackgroundColor: UIColor
        public var selectedTextColor: UIColor
        public var selectedBorderColor: UIColor
        public var normalBackgroundColor: UIColor
        public var normalTextColor: UIColor
        public var normalBorderColor: UIColor
        
        public init(selectedBackgroundColor: UIColor, selectedTextColor: UIColor, selectedBorderColor: UIColor, normalBackgroundColor: UIColor, normalTextColor: UIColor, normalBorderColor: UIColor) {
            self.selectedBackgroundColor = selectedBackgroundColor
            self.selectedTextColor = selectedTextColor
            self.selectedBorderColor = selectedBorderColor
            self.normalBackgroundColor = normalBackgroundColor
            self.normalTextColor = normalTextColor
            self.normalBorderColor = normalBorderColor
        }

    }

    public var tagStyle: TagStyle?
    
    private var sizingLabel = UILabel(frame: .zero)
    
    private var lastDimension: CGSize?
    
    private var originalHeight: CGFloat?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        return view
    }()
    
    public var hashtags: [HashTag] = []
    
    public var delegate: HashtagViewDelegate?
    public var currentNumberOfline : Int = 0;
    
    
    @IBInspectable
    open var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    // MARK: Container padding (insets)
    
    @IBInspectable
    open var containerPaddingLeft: CGFloat = 10.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable
    open var containerPaddingRight: CGFloat = 10.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable
    open var containerPaddingTop: CGFloat = 10.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable
    open var containerPaddingBottom: CGFloat = 10.0 {
        didSet {
            setup()
        }
    }
    
    // MARK: Hashtag cell padding
    
    @IBInspectable
    open var tagPaddingLeft: CGFloat = 5.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var tagPaddingRight: CGFloat = 5.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var tagPaddingTop: CGFloat = 5.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var tagPaddingBottom: CGFloat = 5.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var tagCornerRadius: CGFloat = 5.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var textSize: CGFloat = 14.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var tagBackgroundColor: UIColor = .lightGray {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var tagTextColor: UIColor = .white {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var removeButtonSize: CGFloat = 10.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    @IBInspectable
    open var removeButtonSpacing: CGFloat = 5.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Hashtags cell margins
    
    @IBInspectable
    open var horizontalTagSpacing: CGFloat = 5.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable
    open var verticalTagSpacing: CGFloat = 5.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable
    open var borderWidth: CGFloat = 1.0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBInspectable
    open var borderColor: UIColor = .clear {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    open var maxLine: Int = 0 {
        didSet {
            setup()
        }
    }
    
    open var removeIconName: UIImage? {
        didSet {
            setup()
        }
    }
    
    open var defaultFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            setup()
        }
    }
    
    open var selectedFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            setup()
        }
    }
    
    open var isSelectable = true {
        didSet {
            setup()
        }
    }
    
    // MARK: Constructors
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.addTag(tag: HashTag(word: "hashtag"))
        self.addTag(tag: HashTag(word: "hashtag", withHashSymbol: true, isRemovable: false))
        self.addTag(tag: HashTag(word: "RemovableHashtag", isRemovable: true))
    }
    
    open override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        
        var size = self.collectionView.collectionViewLayout.collectionViewContentSize
        
        size.width = size.width + self.containerPaddingLeft + self.containerPaddingRight
        size.height = size.height + self.containerPaddingTop + self.containerPaddingBottom
        
        if size.width == 0 || size.height == 0 {
            size = CGSize(width: 100, height:44)
        }
        
        return size
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
    
    func makeConfiguration() -> HashtagConfiguration {
        
        let configuration = HashtagConfiguration()
        
        configuration.paddingLeft = self.tagPaddingLeft
        configuration.paddingRight = self.tagPaddingRight
        configuration.paddingTop = self.tagPaddingTop
        configuration.paddingBottom = self.tagPaddingBottom
        configuration.removeButtonSize = self.removeButtonSize
        configuration.removeButtonSpacing = self.removeButtonSpacing
        configuration.backgroundColor = self.tagBackgroundColor
        configuration.cornerRadius = self.tagCornerRadius
        configuration.textSize = self.textSize
        configuration.textColor = self.tagTextColor
        configuration.selectedTextFont = self.selectedFont;
        configuration.deSelectedTextFont = self.defaultFont;
        configuration.maxLine = self.maxLine;
        configuration.removeImage = self.removeIconName
        configuration.isSelectable = self.isSelectable;
        configuration.borderColor = self.borderColor
        configuration.borderWidth = self.borderWidth
        return configuration
    }
    
    func setup() {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.cornerRadius
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        alignedFlowLayout.minimumLineSpacing = self.horizontalTagSpacing
        alignedFlowLayout.minimumInteritemSpacing = self.verticalTagSpacing
        alignedFlowLayout.sectionInset = UIEdgeInsets(top: self.containerPaddingTop,
                                                      left: self.containerPaddingLeft,
                                                      bottom: self.containerPaddingBottom,
                                                      right: self.containerPaddingRight)
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.collectionViewLayout = alignedFlowLayout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.isScrollEnabled = false
        self.collectionView.allowsSelection = true;
        self.collectionView.allowsMultipleSelection = true;
        
        
        self.collectionView.register(HashtagCollectionViewCell.self,
                                     forCellWithReuseIdentifier: HashtagCollectionViewCell.cellIdentifier)
        self.collectionView.register(RemovableHashtagCollectionViewCell.self,
                                     forCellWithReuseIdentifier: RemovableHashtagCollectionViewCell.cellIdentifier)
        
        
        self.collectionView.removeFromSuperview()
        self.addSubview(self.collectionView)
        
    }
    
    func resize() {
        
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        
        if self.lastDimension != nil{
            if(lastDimension!.height < contentSize.height){
                let line = currentNumberOfline + 1;
                
                if(line < maxLine){
                    currentNumberOfline = line;
                    self.lastDimension = contentSize
                    self.invalidateIntrinsicContentSize()
                }
            }else{
                self.lastDimension = contentSize
            }
            
        }else{
            self.lastDimension = contentSize
            self.invalidateIntrinsicContentSize()

        }
        
        return
        
        
    }
    
    func getSelectedHash() -> [HashTag]{
        
        let index = collectionView.indexPathsForSelectedItems
        var tags : [HashTag] = [];
        
        if let indexs = index{
            for i in indexs{
                tags.append(hashtags[i.item]);
            }
        }
        
        return tags;
    }
    
}

extension HashtagView {
    
    open func reload(){
        self.collectionView.contentSize = CGSize.init(width: 0, height: 0);
        
        var tags : [HashTag] = [];
        tags.append(contentsOf: self.hashtags) ;
        
        self.removeTags()
        
        for tag in tags{
            self.addTag(tag: tag);
        }
    }
    
    open func addTag(tag: HashTag) {
        self.hashtags.append(tag)
        self.collectionView.reloadData()
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
        
        
        resize()
    }
    
    open func addTags(tags: [HashTag]) {
        self.hashtags.append(contentsOf: tags)
        self.collectionView.reloadData()
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
        
        resize()
    }
    
    open func notifyCells() {
        
        for idx in 0..<self.hashtags.count {
            
            if (self.hashtags[idx].isSelected) {
                collectionView.selectItem(at: IndexPath(item: idx, section: 0), animated: false, scrollPosition: .top)
            }
        }
    }
    
    open func removeTag(tag: HashTag) {
        self.hashtags.remove(object: tag)
        self.collectionView.reloadData()
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
        self.invalidateIntrinsicContentSize();
        
    }
    
    open func removeTags() {
        self.currentNumberOfline = 0
        self.lastDimension = nil;
        self.hashtags.removeAll()
        self.collectionView.reloadData()
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
        self.invalidateIntrinsicContentSize();
    }
    
    open func getTags() -> [HashTag] {
        return self.hashtags
    }
    
    func applyStyle(to cell: HashtagCollectionViewCell, isSelected: Bool) {
        guard let tagStyle = tagStyle else { return }
        
        if isSelected {
            cell.backgroundColor = tagStyle.selectedBackgroundColor
            cell.wordLabel.textColor = tagStyle.selectedTextColor
            cell.layer.borderWidth = 1
            cell.layer.borderColor = tagStyle.selectedBorderColor.cgColor
        } else {
            cell.backgroundColor = tagStyle.normalBackgroundColor
            cell.wordLabel.textColor = tagStyle.normalTextColor
            cell.layer.borderWidth = 1
            cell.layer.borderColor = tagStyle.normalBorderColor.cgColor
        }
    }
}

extension HashtagView: RemovableHashtagDelegate {
    public func onRemoveHashtag(hashtag: HashTag) {
        removeTag(tag: hashtag)
        self.delegate?.hashtagRemoved(hashtag: hashtag)
    }
}

extension HashtagView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hashtags.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hashtag: HashTag = self.hashtags[indexPath.item]
        
        if hashtag.isRemovable {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemovableHashtagCollectionViewCell.cellIdentifier,
                                                          for: indexPath) as! RemovableHashtagCollectionViewCell
            
            cell.delegate = self
            cell.configureWithTag(tag: hashtag, configuration: makeConfiguration())
            cell.bringSubviewToFront(cell.removeButton)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HashtagCollectionViewCell.cellIdentifier,
                                                      for: indexPath) as! HashtagCollectionViewCell
        
        cell.configureWithTag(tag: hashtag, configuration: makeConfiguration())
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard isSelectable else{
            return
        }
        
        delegate?.hashTagSelected(indexPath: indexPath, isSelected: true);
        
        self.hashtags[indexPath.item].isSelected = true;
        
        if let cell = collectionView.cellForItem(at: indexPath) as? HashtagCollectionViewCell {
            cell.configureWithTag(tag: self.hashtags[indexPath.item], configuration: makeConfiguration())
            applyStyle(to: cell, isSelected: true)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! RemovableHashtagCollectionViewCell
            cell.configureWithTag(tag: self.hashtags[indexPath.item], configuration: makeConfiguration())
        }
        
        
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        guard isSelectable else{
            return
        }
        
        delegate?.hashTagSelected(indexPath: indexPath, isSelected: false);
        
        self.hashtags[indexPath.item].isSelected = false;
        
        if let cell = collectionView.cellForItem(at: indexPath) as? HashtagCollectionViewCell {
            cell.configureWithTag(tag: self.hashtags[indexPath.item], configuration: makeConfiguration())
            applyStyle(to: cell, isSelected: false)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! RemovableHashtagCollectionViewCell
            cell.configureWithTag(tag: self.hashtags[indexPath.item], configuration: makeConfiguration())
        }
        
    }
}

extension HashtagView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hashtag: HashTag = self.hashtags[indexPath.item]
        
        let config = self.makeConfiguration()
        
        var wordSize = hashtag.text.sizeOfString(usingFont: config.deSelectedTextFont ?? UIFont.systemFont(ofSize: 14));
        
        if(hashtag.isSelected){
            wordSize = hashtag.text.sizeOfString(usingFont: config.selectedTextFont ?? UIFont.systemFont(ofSize: 14));
        }
        
        var calculatedHeight = CGFloat()
        var calculatedWidth = CGFloat()
        
        calculatedHeight = self.tagPaddingTop + wordSize.height + self.tagPaddingBottom
        calculatedWidth = self.tagPaddingLeft + wordSize.width + self.tagPaddingRight + 1
        
        if hashtag.isRemovable {
            calculatedWidth += self.removeButtonSize + self.removeButtonSpacing
        }
        return CGSize(width: calculatedWidth, height: calculatedHeight)
    }
    
}
