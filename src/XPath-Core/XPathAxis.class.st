"
A class for storing the axis of a step while it is being parsed.
"
Class {
	#name : #XPathAxis,
	#superclass : #Object,
	#instVars : [
		'axisSpecifier',
		'replacementSelector',
		'defaultNodeTestParserContextClass',
		'isImplicit',
		'isStartOfRelativeLocationPath'
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
			replacementSelector := nil.
			defaultNodeTestParserContextClass := nil].
	axisSpecifier := anAxisSpecifier.
	isImplicit := false.
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
	self reset.
]

{ #category : #testing }
XPathAxis >> isImplicit [
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

{ #category : #accessing }
XPathAxis >> replacementSelector [
	^ replacementSelector
		ifNil: [
			self lookupAxisSpecifier.
			replacementSelector]
]

{ #category : #initialization }
XPathAxis >> reset [
	axisSpecifier := 'child'.
	replacementSelector := '/'.
	defaultNodeTestParserContextClass := XPathNodeTestParserElementContext.
	isImplicit := true.
	isStartOfRelativeLocationPath := false.
]

{ #category : #accessing }
XPathAxis >> startRelativeLocationPath [
	isStartOfRelativeLocationPath := true
]
