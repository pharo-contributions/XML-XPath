"
This is a base class for AST location path step nodes.
"
Class {
	#name : #XPathASTStepNode,
	#superclass : #XPathASTNode,
	#instVars : [
		'nodeTest',
		'predicates'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTStepNode class >> nodeTest: aNodeTest [
	^ self new nodeTest: aNodeTest
]

{ #category : #'instance creation' }
XPathASTStepNode class >> nodeTest: aNodeTest predicates: aPredicateCollection [
	^ (self nodeTest: aNodeTest)
		predicates: aPredicateCollection
]

{ #category : #visiting }
XPathASTStepNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitStep: self
]

{ #category : #adding }
XPathASTStepNode >> addPredicate: aPredicate [
	^ self predicates addLast: (self beParentOf: aPredicate)
]

{ #category : #testing }
XPathASTStepNode >> hasPredicates [
	^ predicates notNil
		and: [predicates notEmpty]
]

{ #category : #testing }
XPathASTStepNode >> isFilterable [
	^ true
]

{ #category : #testing }
XPathASTStepNode >> isForwardAxisStep [
	^ false
]

{ #category : #testing }
XPathASTStepNode >> isPredicateLocationPathStep [
	^ self hasParent
		and: [| locationPath |
			(locationPath := self parent) hasParent
				and: [locationPath parent isPredicate]]
]

{ #category : #testing }
XPathASTStepNode >> isRelativeOrAbsoluteLocationPathStep [
	^ self hasParent
		and: [| locationPath |
			(locationPath := self parent) isRelativeLocationPath
				or: [locationPath isAbsoluteLocationPath]]
]

{ #category : #testing }
XPathASTStepNode >> isReverseAxisStep [
	^ false
]

{ #category : #testing }
XPathASTStepNode >> isSoleStep [
	^ self hasParent not
		or: [self parent totalSteps = 1]
]

{ #category : #testing }
XPathASTStepNode >> isStep [
	^ true
]

{ #category : #testing }
XPathASTStepNode >> isUnaryOrLiteralBinaryOperatorLocationPathStep [
	^ self hasParent
		and: [| locationPath |
			(locationPath := self parent) hasParent
				and: [| operator |
					(operator := locationPath parent) isUnaryOperatorExpression
						or: [operator isBinaryOperatorExpression
							and: [operator hasLiteralExpression]]]]
]

{ #category : #accessing }
XPathASTStepNode >> nodeTest [
	^ nodeTest ifNil: [nodeTest := XPathASTNullNode new]
]

{ #category : #accessing }
XPathASTStepNode >> nodeTest: aNode [
	nodeTest := aNode
]

{ #category : #accessing }
XPathASTStepNode >> predicates [
	^ predicates ifNil: [predicates := OrderedCollection new]
]

{ #category : #accessing }
XPathASTStepNode >> predicates: aPredicateCollection [
	predicates := self beParentOfAll: aPredicateCollection asOrderedCollection
]

{ #category : #enumerating }
XPathASTStepNode >> predicatesDo: aBlock [
	predicates
		ifNotNil: [predicates do: aBlock]
]

{ #category : #removing }
XPathASTStepNode >> removePredicate: aPredicate [
	^ self predicates remove: aPredicate
]

{ #category : #removing }
XPathASTStepNode >> removePredicates [
	^ self predicates removeAll
]

{ #category : #accessing }
XPathASTStepNode >> totalPredicates [
	^ predicates
		ifNil: [0]
		ifNotNil: [predicates size]
]
