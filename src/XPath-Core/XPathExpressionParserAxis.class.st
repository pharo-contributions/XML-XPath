"
This class holds the current axis while a step is being parsed by an XPathExpressionParser and maps it to the correct handler selector and to a default node test parser context class (to parse any node test that comes after).
"
Class {
	#name : #XPathExpressionParserAxis,
	#superclass : #Object,
	#instVars : [
		'axisSpecifier',
		'handlerSelector',
		'defaultNodeTestParserContextClass',
		'isImplicit',
		'isStartOfRelativeLocationPath',
		'isFirstAxis'
	],
	#classVars : [
		'AxisSpecifiers'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #private }
XPathExpressionParserAxis class >> axisSpecifiers [
	^ AxisSpecifiers
]

{ #category : #private }
XPathExpressionParserAxis class >> axisSpecifiersTemplate [
	"Returns an array of arrays where each subarray has an axis name,
	a handler selector to map it to, and the principal node type for
	that axis, which is used to determine the parser context class
	when parsing the node test after."

	^ #(
		#('ancestor'           handleAncestorAxis         element)
		#('ancestor-or-self'   handleAncestorOrSelfAxis   element)
		#('attribute'          handleAttributeAxis        attribute)
		#('child'              handleChildAxis            element)
		#('descendant'         handleDescendantAxis       element)
		#('descendant-or-self' handleDescendantOrSelfAxis element)
		#('following'          handleFollowingAxis        element)
		#('following-sibling'  handleFollowingSiblingAxis element)
		#('namespace'          handleNamespaceAxis        namespace)
		#('parent'             handleParentAxis           element)
		#('preceding'          handlePrecedingAxis        element)
		#('preceding-sibling'  handlePrecedingSiblingAxis element)
		#('self'               handleSelfAxis             element)
	)
]

{ #category : #'class initialization' }
XPathExpressionParserAxis class >> initialize [
	"self initialize"

	| temp |

	"use a temp to fully initialize it before assignment to avoid possible
	race conditions during class reinitialization"
	temp := Dictionary new.
	self axisSpecifiersTemplate do: [:each |
		| axisSpecifier handlerSelector principalNodeType parserContextClass |
		axisSpecifier := each first.
		handlerSelector := each second.
		principalNodeType := each third.
		parserContextClass :=
			principalNodeType = #attribute
				ifTrue: [XPathNodeTestParserAttributeContext]
				ifFalse: [
					principalNodeType = #namespace
						ifTrue: [XPathNodeTestParserNamespaceContext]
						ifFalse: [XPathNodeTestParserElementContext]].
		temp
			at: axisSpecifier
			put: handlerSelector -> parserContextClass].
	AxisSpecifiers := temp.
]

{ #category : #accessing }
XPathExpressionParserAxis >> axisSpecifier [
	^ axisSpecifier
]

{ #category : #accessing }
XPathExpressionParserAxis >> axisSpecifier: anAxisSpecifier [
	anAxisSpecifier = axisSpecifier
		ifFalse: [
			axisSpecifier := anAxisSpecifier.
			handlerSelector := nil.
			defaultNodeTestParserContextClass := nil].
	"now explicit"
	isImplicit := false.
]

{ #category : #changing }
XPathExpressionParserAxis >> beDefaultImplicitAxis [
	axisSpecifier := 'child'.
	handlerSelector := #handleChildAxis.
	defaultNodeTestParserContextClass := XPathNodeTestParserElementContext.
	isImplicit := true.
	isFirstAxis := false.
	isStartOfRelativeLocationPath := false.
]

{ #category : #changing }
XPathExpressionParserAxis >> beFirstAxis [
	isFirstAxis := true
]

{ #category : #changing }
XPathExpressionParserAxis >> beStartOfRelativeLocationPath [
	isStartOfRelativeLocationPath := true
]

{ #category : #accessing }
XPathExpressionParserAxis >> defaultNodeTestParserContextClass [
	^ defaultNodeTestParserContextClass
		ifNil: [
			self lookupAxisSpecifier.
			defaultNodeTestParserContextClass]
]

{ #category : #private }
XPathExpressionParserAxis >> errorUnrecognizedAxisSpecifier [
	XPathSyntaxException
		formatSignal: 'Unrecognized axis specifier "{1}"'
		with: self axisSpecifier
]

{ #category : #accessing }
XPathExpressionParserAxis >> handlerSelector [
	^ handlerSelector
		ifNil: [
			self lookupAxisSpecifier.
			handlerSelector]
]

{ #category : #initialization }
XPathExpressionParserAxis >> initialize [
	super initialize.
	self beDefaultImplicitAxis.
]

{ #category : #testing }
XPathExpressionParserAxis >> isFirstAxis [
	^ isFirstAxis
]

{ #category : #testing }
XPathExpressionParserAxis >> isImplicitAxis [
	^ isImplicit
]

{ #category : #testing }
XPathExpressionParserAxis >> isStartOfRelativeLocationPath [
	^ isStartOfRelativeLocationPath
]

{ #category : #private }
XPathExpressionParserAxis >> lookupAxisSpecifier [
	| association |

	association :=
		AxisSpecifiers
			at: self axisSpecifier
			ifAbsent: [self errorUnrecognizedAxisSpecifier].
	handlerSelector := association key.
	defaultNodeTestParserContextClass := association value.
]

{ #category : #printing }
XPathExpressionParserAxis >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self axisSpecifier;
		nextPut: $).
]
