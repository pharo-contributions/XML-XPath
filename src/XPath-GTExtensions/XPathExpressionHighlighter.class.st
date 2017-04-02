"
This class is a highlighter to highlight XPath expression Text objects using XMLHighlights.
"
Class {
	#name : #XPathExpressionHighlighter,
	#superclass : #XMLHighlighter,
	#instVars : [
		'axisColor',
		'nodeTestColor',
		'predicateColors',
		'predicateColorLevel',
		'operatorColor',
		'functionCallColor',
		'stringLiteralColor',
		'numberLiteralColor',
		'variableReferenceColor',
		'axisHighlight',
		'nodeTestHighlight',
		'predicateHighlightStack',
		'operatorHighlight',
		'functionCallHighlightStack',
		'stringLiteralHighlight',
		'numberLiteralHighlight',
		'variableReferenceHighlight'
	],
	#category : #'XPath-GTExtensions-Highlighting'
}

{ #category : #accessing }
XPathExpressionHighlighter >> axisColor [
	^ axisColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> axisColor: aTextColor [
	axisColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> decrementPredicateColorLevel [
	(predicateColorLevel := predicateColorLevel - 1) >= 1
		ifFalse: [
			"wrap around to the last color"
			predicateColorLevel := self maxPredicateColorLevel]
]

{ #category : #accessing }
XPathExpressionHighlighter >> defaults [
	^ XPathExpressionHighlightDefaults
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endAxisHighlightPosition: aPosition [
	self
		endHighlight: axisHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endFunctionCallHighlightPosition: aPosition [
	self
		endHighlight: functionCallHighlightStack removeLast
		position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endNodeTestHighlightPosition: aPosition [
	self
		endHighlight: nodeTestHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endNumberLiteralHighlightPosition: aPosition [
	self
		endHighlight: numberLiteralHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endOperatorHighlightPosition: aPosition [
	self
		endHighlight: operatorHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endPredicateHighlightPosition: aPosition [
	self
		endHighlight: predicateHighlightStack removeLast
		position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endStringLiteralHighlightPosition: aPosition [
	self
		endHighlight: stringLiteralHighlight
		position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> endVariableReferenceHighlightPosition: aPosition [
	self
		endHighlight: variableReferenceHighlight
		position: aPosition
]

{ #category : #accessing }
XPathExpressionHighlighter >> functionCallColor [
	^ functionCallColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> functionCallColor: aTextColor [
	functionCallColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> incrementPredicateColorLevel [
	(predicateColorLevel := predicateColorLevel + 1) <= self maxPredicateColorLevel
		ifFalse: [
			"wrap around to the first color"
			predicateColorLevel := 1]
]

{ #category : #initialization }
XPathExpressionHighlighter >> initializeColors [
	super initializeColors.
	self
		initializePredicateColors;
		axisColor: self defaults defaultAxisColor;
		nodeTestColor: self defaults defaultNodeTestColor;
		predicatePrimaryColor: self defaults defaultPredicatePrimaryColor;
		predicateSecondaryColor: self defaults defaultPredicateSecondaryColor;
		predicateTertiaryColor: self defaults defaultPredicateTertiaryColor;
		operatorColor: self defaults defaultOperatorColor;
		functionCallColor: self defaults defaultFunctionCallColor;
		stringLiteralColor: self defaults defaultStringLiteralColor;
		numberLiteralColor: self defaults defaultNumberLiteralColor;
		variableReferenceColor: self defaults defaultVariableReferenceColor.
]

{ #category : #initialization }
XPathExpressionHighlighter >> initializeHighlights [
	super initializeHighlights.

	predicateHighlightStack := OrderedCollection new.
	functionCallHighlightStack := OrderedCollection new.
]

{ #category : #initialization }
XPathExpressionHighlighter >> initializePredicateColors [
	predicateColors := Array new: self maxPredicateColorLevel.
	predicateColorLevel := 1.
]

{ #category : #private }
XPathExpressionHighlighter >> maxPredicateColorLevel [
	^ 3
]

{ #category : #accessing }
XPathExpressionHighlighter >> nodeTestColor [
	^ nodeTestColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> nodeTestColor: aTextColor [
	nodeTestColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> numberLiteralColor [
	^ numberLiteralColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> numberLiteralColor: aTextColor [
	numberLiteralColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> operatorColor [
	^ operatorColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> operatorColor: aTextColor [
	operatorColor := aTextColor
]

{ #category : #private }
XPathExpressionHighlighter >> predicateColor [
	^ predicateColors at: predicateColorLevel
]

{ #category : #accessing }
XPathExpressionHighlighter >> predicatePrimaryColor [
	^ predicateColors at: 1
]

{ #category : #accessing }
XPathExpressionHighlighter >> predicatePrimaryColor: aTextColor [
	predicateColors
		at: 1
		put: aTextColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> predicateSecondaryColor [
	^ predicateColors at: 2
]

{ #category : #accessing }
XPathExpressionHighlighter >> predicateSecondaryColor: aTextColor [
	predicateColors
		at: 2
		put: aTextColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> predicateTertiaryColor [
	^ predicateColors at: 3
]

{ #category : #accessing }
XPathExpressionHighlighter >> predicateTertiaryColor: aTextColor [
	predicateColors
		at: 3
		put: aTextColor
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startAxisHighlightPosition: aPosition [
	axisHighlight :=
		self
			newHighlightColor: self axisColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startFunctionCallHighlightPosition: aPosition [
	functionCallHighlightStack addLast:
		(self
			newHighlightColor: self functionCallColor
			position: aPosition)
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startNodeTestHighlightPosition: aPosition [
	nodeTestHighlight :=
		self
			newHighlightColor: self nodeTestColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startNumberLiteralHighlightPosition: aPosition [
	numberLiteralHighlight :=
		self
			newHighlightColor: self numberLiteralColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startOperatorHighlightPosition: aPosition [
	operatorHighlight :=
		self
			newHighlightColor: self operatorColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startPredicateHighlightPosition: aPosition [
	predicateHighlightStack addLast:
		(self
			newHighlightColor: self predicateColor
			position: aPosition)
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startStringLiteralHighlightPosition: aPosition [
	stringLiteralHighlight :=
		self
			newHighlightColor: self stringLiteralColor
			position: aPosition
]

{ #category : #'highlighting - positions' }
XPathExpressionHighlighter >> startVariableReferenceHighlightPosition: aPosition [
	variableReferenceHighlight :=
		self
			newHighlightColor: self variableReferenceColor
			position: aPosition
]

{ #category : #accessing }
XPathExpressionHighlighter >> stringLiteralColor [
	^ stringLiteralColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> stringLiteralColor: aTextColor [
	stringLiteralColor := aTextColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> variableReferenceColor [
	^ variableReferenceColor
]

{ #category : #accessing }
XPathExpressionHighlighter >> variableReferenceColor: aTextColor [
	variableReferenceColor := aTextColor
]
