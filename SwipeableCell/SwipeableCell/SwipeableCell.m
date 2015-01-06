//
//  SwipeableCell.m
//  SwipeableCell
//
//  Created by BILLY HO on 12/31/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "SwipeableCell.h"
static CGFloat const kBounceValue = 10.0f;
static CGFloat const kConstraintPadding = 8.0f;

@interface SwipeableCell () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
@property (nonatomic) BOOL shouldOpenCell;
@property (nonatomic) BOOL isPanHorizontal;

@end

@implementation SwipeableCell

- (void)awakeFromNib {
    // Initialization code
	[super awakeFromNib];
 
	self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
	self.panRecognizer.delegate = self;
	[self.myContentView addGestureRecognizer:self.panRecognizer];
}

- (void)panThisCell:(UIPanGestureRecognizer *)recognizer
{
	switch (recognizer.state)
	{
		case UIGestureRecognizerStateBegan:
		{
			self.panStartPoint = [recognizer translationInView:self.myContentView];
			self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
			NSLog(@"Pan Began at %@", NSStringFromCGPoint(self.panStartPoint));
			if (self.delegate) {
				_shouldOpenCell = [self.delegate cellShouldOpen:self];
			} else {
				_shouldOpenCell = YES;
			}
			if (abs(self.panStartPoint.x) > abs(self.panStartPoint.y))
			{
				_isPanHorizontal = YES;
			}
			else
			{
				_isPanHorizontal = NO;
			}
			break;
		}
		case UIGestureRecognizerStateChanged:
		{
			CGPoint currentPoint = [recognizer translationInView:self.myContentView];
			CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
			if (_isPanHorizontal && _shouldOpenCell)
			{
				if (self.delegate ){
					[self.delegate cellWillOpen:self];
				}
				BOOL panningLeft = NO;
				if (currentPoint.x < self.panStartPoint.x) {  //1
					panningLeft = YES;
				}
				
				CGFloat adjustment = self.startingRightLayoutConstraintConstant - deltaX; //1
				if (!panningLeft)
				{
					CGFloat constant = MAX(adjustment, -2*kConstraintPadding); //2
					self.contentViewRightConstraint.constant = constant;
				}
				else
				{
					CGFloat constant = MIN(adjustment, [self buttonTotalWidth]); //5
					self.contentViewRightConstraint.constant = constant;
					
				}
				
				
				self.contentViewLeftConstraint.constant = -self.contentViewRightConstraint.constant - 2 * kConstraintPadding; //8
			}
			
			break;
		}
		case UIGestureRecognizerStateEnded:
		{
			NSLog(@"Pan Ended");
			if (self.startingRightLayoutConstraintConstant == -kConstraintPadding)
			{ //1
				CGFloat mostOfButtonOne = CGRectGetWidth(self.button1.frame) * 0.75;
				
				if (self.contentViewRightConstraint.constant >= mostOfButtonOne - kConstraintPadding) { //5
					//Open all the way
					[self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
				} else {
					//Close
					[self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
				}
			}
			else
			{
				//Cell was closing
				CGFloat buttonOnePlusButton2 = CGRectGetWidth(self.button1.frame) + (CGRectGetWidth(self.button2.frame)); //4
				if (self.contentViewRightConstraint.constant >= buttonOnePlusButton2 - kConstraintPadding) { //5
					//Re-open all the way
					[self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
				} else {
					//Close
					[self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
				}
			}
			break;
		}
		case UIGestureRecognizerStateCancelled:
		{
			NSLog(@"Pan Cancelled");
			if (self.startingRightLayoutConstraintConstant == -kConstraintPadding) {
				//Cell was closed - reset everything to 0
				[self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
			} else {
				//Cell was open - reset to the open state
				[self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
			}
			break;
		}
		default:
			break;
	}
}

- (CGFloat)buttonTotalWidth
{
	return CGRectGetWidth(self.frame) - CGRectGetMinX(self.button2.frame);
}

- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)notifyDelegate {
	//TODO: Notify delegate.
 
	if (self.startingRightLayoutConstraintConstant == -kConstraintPadding &&
		self.contentViewRightConstraint.constant == -kConstraintPadding) {
		//Already all the way closed, no bounce necessary
		return;
	}
 
	self.contentViewRightConstraint.constant = -kBounceValue - kConstraintPadding;
	self.contentViewLeftConstraint.constant = kBounceValue - kConstraintPadding;
 
	[self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
		self.contentViewRightConstraint.constant = -kConstraintPadding;
		self.contentViewLeftConstraint.constant = -kConstraintPadding;
		
		[self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
			self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
		}];
	}];
	if (notifyDelegate) {
		[self.delegate cellDidClose:self];
	}
}

- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate {
	//TODO: Notify delegate.
 
	//1
	if (self.startingRightLayoutConstraintConstant == [self buttonTotalWidth] - kConstraintPadding &&
		self.contentViewRightConstraint.constant == [self buttonTotalWidth] - kConstraintPadding) {
		return;
	}
	//2
	self.contentViewLeftConstraint.constant = -[self buttonTotalWidth] - kBounceValue - kConstraintPadding;
	self.contentViewRightConstraint.constant = [self buttonTotalWidth] + kBounceValue - kConstraintPadding;
 
	[self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
		//3
		self.contentViewLeftConstraint.constant = -[self buttonTotalWidth] - kConstraintPadding;
		self.contentViewRightConstraint.constant = [self buttonTotalWidth] - kConstraintPadding;
		
		[self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
			//4
			self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
		}];
	}];
	if (notifyDelegate) {
		[self.delegate cellDidOpen:self];
	}
}

- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
	float duration = 0;
	if (animated) {
		duration = 0.1;
	}
 
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		[self layoutIfNeeded];
	} completion:completion];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItemText:(NSString *)itemText {
	//Update the instance variable
	_itemText = itemText;
 
	//Set the text to the custom label.
	self.myTextLabel.text = _itemText;
}

- (IBAction)buttonClicked:(id)sender {
	if (sender == self.button1) {
		[self.delegate buttonOneActionForItemText:self.itemText];
	} else if (sender == self.button2) {
		[self.delegate buttonTwoActionForItemText:self.itemText];
	} else {
		NSLog(@"Clicked unknown button!");
	}
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

- (void)prepareForReuse {
	[super prepareForReuse];
	[self resetConstraintContstantsToZero:NO notifyDelegateDidClose:NO];
}

- (void)openCell {
	[self setConstraintsToShowAllButtons:NO notifyDelegateDidOpen:NO];
}

- (void)closeCell
{
	[self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
}
@end
