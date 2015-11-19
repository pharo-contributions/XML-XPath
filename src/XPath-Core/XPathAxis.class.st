"
This class holds the current axis while a step is being parsed and maps them to selectors and parser context classes.
"
Class {
	#name : #XPathAxis,
	#superclass : #Object,
	#instVars : [
		'axisSpecifier',
		'replacementSelector',
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
	^ #(
		#('ancestor'           '%%'  element)
		#('ancestor-or-self'   '%%~' element)
		#('attribute'          '@'   attribute)
		#('child'              '/'   element)
		#('descendant'         '//'  element)
		#('descendant-or-self' '//~' element)
		#('following'          '>>'  element)
		#('following-sibling'  '>>>' element)
		#('namespace'          '@@'  namespace)
		#('parent'             '%'   element)
		#('preceding'          '<<'  element)
		#('preceding-sibling'  '<<<' element)
		#('self'               '~'   element)
		#('%%'                 '%%'  element)
		#('%%~'                '%%~' element)
		#('@'                  '@'   attribute)
		#('@@'                 '@@'  namespace)
		#('>>'                 '>>'  element)
		#('>>>'                '>>>' element)
		#('%'                  '%'   element)
		#('<<'                 '<<'  element)
		#('<<<'                '<<<' element)
		#('~'                  '~'   element)
	)
]

{ #category : #'class initialization' }
XPathAxis class >> initialize [
	"self initialize"

	self initializeAxisSpecifiers
]

{ #category : #'class initialization' }
XPathAxis class >> initializeAxisSpecifiers [
	AxisSpecifiers := Dictionary new.

	self axisSpecifiersTemplate do: [:threeElementArray |
		| axisSpecifier replacementSelector principalNodeType defaultNodeTestParserContextClass |

		axisSpecifier := threeElementArray first.
		replacementSelector := threeElementArray second.
		principalNodeType := threeElementArray third.
		defaultNodeTestParserContextClass :=
			principalNodeType = #attribute
				ifTrue: [XPathNodeTestParserAttributeContext]
				ifFalse: [
					principalNodeType = #namespace
						ifTrue: [XPathNodeTestParserNamespaceContext]
						ifFalse: [XPathNodeTestParserElementContext]].

		AxisSpecifiers
			at: axisSpecifier
			put: replacementSelector -> defaultNodeTestParserContextClass].
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
			replacementSelector := nil.
			defaultNodeTestParserContextClass := nil].
	"now explicit"
	isImplicit := false.
]

{ #category : #changing }
XPathAxis >> beDefaultImplicitAxis [
	axisSpecifier := 'child'.
	replacementSelector := '/'.
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
	replacementSelector := association key.
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

{ #category : #accessing }
XPathAxis >> replacementSelector [
	^ replacementSelector
		ifNil: [
			self lookupAxisSpecifier.
			replacementSelector]
]
