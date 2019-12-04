"
This class stores the default highlight TextColors used by the XPath expression highlighter. It gets the initial defaults from Shout text styling.
"
Class {
	#name : #XPathExpressionHighlightDefaults,
	#superclass : #XMLHighlightDefaults,
	#classInstVars : [
		'defaultAxisColor',
		'defaultNodeTestColor',
		'defaultPredicateLevelOneColor',
		'defaultPredicateLevelTwoColor',
		'defaultPredicateLevelThreeColor',
		'defaultPredicateLevelFourColor',
		'defaultPredicateLevelFiveColor',
		'defaultPredicateLevelSixColor',
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
		ifNil: [defaultAxisColor := TextColor color: (Color r: 0.0 g: 0.5 b: 0.5) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultAxisColor: aTextColor [
	defaultAxisColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultFunctionCallColor [
	^ defaultFunctionCallColor
		ifNil: [ defaultFunctionCallColor := TextColor color: Color black ].
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultFunctionCallColor: aTextColor [
	defaultFunctionCallColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNodeTestColor [
	^ defaultNodeTestColor
		ifNil: [ defaultNodeTestColor := TextColor color: (Color r: 0.0 g: 0.0 b: 0.5) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNodeTestColor: aTextColor [
	defaultNodeTestColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNumberLiteralColor [
	^ defaultNumberLiteralColor
		ifNil: [ defaultNumberLiteralColor := TextColor color: (Color r: 0.5 g: 0.0 b: 0.0) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultNumberLiteralColor: aTextColor [
	defaultNumberLiteralColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultOperatorColor [
	^ defaultOperatorColor
		ifNil: [defaultOperatorColor := TextColor color: Color black ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultOperatorColor: aTextColor [
	defaultOperatorColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelFiveColor [
	^ defaultPredicateLevelFiveColor
		ifNil: [
			defaultPredicateLevelFiveColor := TextColor color: (Color r: 0.92 g: 0.552 b: 0.0)]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelFiveColor: aTextColor [
	defaultPredicateLevelFiveColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelFourColor [
	^ defaultPredicateLevelFourColor
		ifNil: [
			defaultPredicateLevelFourColor := TextColor color: (Color r: 0.0 g: 0.92 b: 0.0)]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelFourColor: aTextColor [
	defaultPredicateLevelFourColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelOneColor [
	^ defaultPredicateLevelOneColor
		ifNil: [
			defaultPredicateLevelOneColor := TextColor color: (Color r: 0.0 g: 0.5 b: 0.0)]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelOneColor: aTextColor [
	defaultPredicateLevelOneColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelSixColor [
	^ defaultPredicateLevelSixColor
		ifNil: [
			defaultPredicateLevelSixColor := TextColor color: (Color r: 0.92 g: 0.0 b: 0.92) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelSixColor: aTextColor [
	defaultPredicateLevelSixColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelThreeColor [
	^ defaultPredicateLevelThreeColor
		ifNil: [
			defaultPredicateLevelThreeColor := TextColor color: (Color r: 0.5 g: 0.0 b: 0.0) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelThreeColor: aTextColor [
	defaultPredicateLevelThreeColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelTwoColor [
	^ defaultPredicateLevelTwoColor
		ifNil: [
			defaultPredicateLevelTwoColor := TextColor color: (Color r: 0.5 g: 0.0 b: 0.5) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultPredicateLevelTwoColor: aTextColor [
	defaultPredicateLevelTwoColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultStringLiteralColor [
	^ defaultStringLiteralColor
		ifNil: [defaultStringLiteralColor := TextColor color: (Color r: 0.5 g: 0.0 b: 0.5) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultStringLiteralColor: aTextColor [
	defaultStringLiteralColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultVariableReferenceColor [
	^ defaultVariableReferenceColor
		ifNil: [defaultVariableReferenceColor := TextColor color: (Color r: 0.0 g: 0.0 b: 0.5) ]
]

{ #category : #accessing }
XPathExpressionHighlightDefaults class >> defaultVariableReferenceColor: aTextColor [
	defaultVariableReferenceColor := aTextColor
]

{ #category : #'class initialization' }
XPathExpressionHighlightDefaults class >> resetDefaults [
	super resetDefaults.

	defaultAxisColor := nil.
	defaultNodeTestColor := nil.
	defaultPredicateLevelOneColor := nil.
	defaultPredicateLevelTwoColor := nil.
	defaultPredicateLevelThreeColor := nil.
	defaultPredicateLevelFourColor := nil.
	defaultPredicateLevelFiveColor := nil.
	defaultPredicateLevelSixColor := nil.
	defaultOperatorColor := nil.
	defaultFunctionCallColor := nil.
	defaultStringLiteralColor := nil.
	defaultNumberLiteralColor := nil.
	defaultVariableReferenceColor := nil.
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> axisColor [
	^ self class defaultAxisColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> functionCallColor [
	^ self class defaultFunctionCallColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> nodeTestColor [
	^ self class defaultNodeTestColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> numberLiteralColor [
	^ self class defaultNumberLiteralColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> operatorColor [
	^ self class defaultOperatorColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> predicateLevelFiveColor [
	^ self class defaultPredicateLevelFiveColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> predicateLevelFourColor [
	^ self class defaultPredicateLevelFourColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> predicateLevelOneColor [
	^ self class defaultPredicateLevelOneColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> predicateLevelSixColor [
	^ self class defaultPredicateLevelSixColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> predicateLevelThreeColor [
	^ self class defaultPredicateLevelThreeColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> predicateLevelTwoColor [
	^ self class defaultPredicateLevelTwoColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> stringLiteralColor [
	^ self class defaultStringLiteralColor
]

{ #category : #defaults }
XPathExpressionHighlightDefaults >> variableReferenceColor [
	^ self class defaultVariableReferenceColor
]
