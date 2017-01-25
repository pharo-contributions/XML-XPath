"
This class holds the current axis while a step is being parsed and maps them to handler selectors and parser context classes to parse the node test that comes after.
"
Class {
	#name : #XPathAxis,
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
XPathAxis class >> axisSpecifiers [
	^ AxisSpecifiers
]

{ #category : #private }
XPathAxis class >> axisSpecifiersTemplate [
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
XPathAxis class >> initialize [
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
XPathAxis >> axisSpecifier [
	^ axisSpecifier
]

{ #category : #accessing }
XPathAxis >> axisSpecifier: anAxisSpecifier [
	anAxisSpecifier = axisSpecifier
		ifFalse: [
			axisSpecifier := anAxisSpecifier.
			handlerSelector := nil.
			defaultNodeTestParserContextClass := nil].
	"now explicit"
	isImplicit := false.
]

{ #category : #changing }
XPathAxis >> beDefaultImplicitAxis [
	axisSpecifier := 'child'.
	handlerSelector := #handleChildAxis.
	defaultNodeTestParserContextClass := XPathNodeTestParserElementContext.
	isImplicit := true.
	isFirstAxis := false.
	isStartOfRelativeLocationPath := false.
]

{ #category : #changing }
XPathAxis >> beFirstAxis [
	isFirstAxis := true
]

{ #category : #changing }
XPathAxis >> beStartOfRelativeLocationPath [
	isStartOfRelativeLocationPath := true
]

{ #category : #accessing }
XPathAxis >> defaultNodeTestParserContextClass [
	^ defaultNodeTestParserContextClass
		ifNil: [
			self lookupAxisSpecifier.
			defaultNodeTestParserContextClass]
]

{ #category : #private }
XPathAxis >> errorUnrecognizedAxisSpecifier [
	XPathSyntaxException
		formatSignal: 'Unrecognized axis specifier "{1}"'
		with: self axisSpecifier
]

{ #category : #accessing }
XPathAxis >> handlerSelector [
	^ handlerSelector
		ifNil: [
			self lookupAxisSpecifier.
			handlerSelector]
]

{ #category : #initialization }
XPathAxis >> initialize [
	super initialize.
	self beDefaultImplicitAxis.
]

{ #category : #testing }
XPathAxis >> isFirstAxis [
	^ isFirstAxis
]

{ #category : #testing }
XPathAxis >> isImplicitAxis [
	^ isImplicit
]

{ #category : #testing }
XPathAxis >> isStartOfRelativeLocationPath [
	^ isStartOfRelativeLocationPath
]

{ #category : #private }
XPathAxis >> lookupAxisSpecifier [
	| association |

	association :=
		AxisSpecifiers
			at: self axisSpecifier
			ifAbsent: [self errorUnrecognizedAxisSpecifier].
	handlerSelector := association key.
	defaultNodeTestParserContextClass := association value.
]

{ #category : #printing }
XPathAxis >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self axisSpecifier;
		nextPut: $).
]
