"
This class stores the default highlight TextColors used by the XPath expression highlighter. It gets the initial defaults from Shout text styling.
"
Class {
	#name : #XPathExpressionHighlightDefaults,
	#superclass : #XMLHighlightDefaults,
	#classInstVars : [
		'defaultAxisColor',
		'defaultNodeTestColor',
		'defaultPredicatePrimaryColor',
		'defaultPredicateSecondaryColor',
		'defaultPredicateTertiaryColor',
		'defaultOperatorColor',
		'defaultFunctionCallColor',
		'defaultStringLiteralColor',
		'defaultNumberLiteralColor',
		'defaultVariableReferenceColor'
	],
	#category : #'XPath-GTExtensions-Highlighting'
}

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultAxisColor [
	^ defaultAxisColor
		ifNil: [defaultAxisColor := self textColorForShoutProperty: #self]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultAxisColor: aTextColor [
	defaultAxisColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultFunctionCallColor [
	^ defaultFunctionCallColor
		ifNil: [defaultFunctionCallColor := self textColorForShoutProperty: #keyword].
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultFunctionCallColor: aTextColor [
	defaultFunctionCallColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNodeTestColor [
	^ defaultNodeTestColor
		ifNil: [defaultNodeTestColor := self textColorForShoutProperty: #instVar]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNodeTestColor: aTextColor [
	defaultNodeTestColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNumberLiteralColor [
	^ defaultNumberLiteralColor
		ifNil: [defaultNumberLiteralColor := self textColorForShoutProperty: #number]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNumberLiteralColor: aTextColor [
	defaultNumberLiteralColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultOperatorColor [
	^ defaultOperatorColor
		ifNil: [defaultOperatorColor := self textColorForShoutProperty: #binary]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultOperatorColor: aTextColor [
	defaultOperatorColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicatePrimaryColor [
	^ defaultPredicatePrimaryColor
		ifNil: [
			defaultPredicatePrimaryColor :=
				self textColorForShoutProperty: #blockStart1]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicatePrimaryColor: aTextColor [
	defaultPredicatePrimaryColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateSecondaryColor [
	^ defaultPredicateSecondaryColor
		ifNil: [
			defaultPredicateSecondaryColor :=
				self textColorForShoutProperty: #blockStart2]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateSecondaryColor: aTextColor [
	defaultPredicateSecondaryColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateTertiaryColor [
	^ defaultPredicateTertiaryColor
		ifNil: [
			defaultPredicateTertiaryColor :=
				self textColorForShoutProperty: #blockStart3]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateTertiaryColor: aTextColor [
	defaultPredicateTertiaryColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultStringLiteralColor [
	^ defaultStringLiteralColor
		ifNil: [defaultStringLiteralColor := self textColorForShoutProperty: #string]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultStringLiteralColor: aTextColor [
	defaultStringLiteralColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultVariableReferenceColor [
	^ defaultVariableReferenceColor
		ifNil: [defaultVariableReferenceColor := self textColorForShoutProperty: #globalVar]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultVariableReferenceColor: aTextColor [
	defaultVariableReferenceColor := aTextColor
]

{ #category : #'class initialization' }
XPathExpressionHighlightDefaults class >> initialize [
	"self initialize"

	defaultDefaultColor := nil.
	defaultAxisColor := nil.
	defaultNodeTestColor := nil.
	defaultPredicatePrimaryColor := nil.
	defaultPredicateSecondaryColor := nil.
	defaultPredicateTertiaryColor := nil.
	defaultOperatorColor := nil.
	defaultFunctionCallColor := nil.
	defaultStringLiteralColor := nil.
	defaultNumberLiteralColor := nil.
	defaultVariableReferenceColor := nil.
]
