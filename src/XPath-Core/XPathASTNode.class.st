"
This is a base class for XPath AST nodes. It has testing messages, messages to access the parent, and a stub node visitor accepting method.
"
Class {
	#name : #XPathASTNode,
	#superclass : #Object,
	#instVars : [
		'parent',
		'type'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #private }
XPathASTNode class >> generateTestingMethods [
	"self generateTestingMethods"

	self allSubclassesDo: [:each | | selectorString |
		selectorString := 'is', each nameWithoutPrefixAndSuffix.
		each
			compile: selectorString, '
	^ true'
			classified: #testing.
		self
			compile: selectorString, '
	^ false'
			classified: #testing]
]

{ #category : #private }
XPathASTNode class >> generateVisitingMethods [
	"self generateVisitingMethods"

	self allSubclassesDo: [:each | | nameWithoutPrefixAndSuffix |
		nameWithoutPrefixAndSuffix := each nameWithoutPrefixAndSuffix.
		each
			compile: 'acceptNodeVisitor: aNodeVisitor
	aNodeVisitor visit', nameWithoutPrefixAndSuffix, ': self'
			classified: #visiting.
		XPathASTNodeVisitor
			compile:
				'visit', nameWithoutPrefixAndSuffix, ': ',
					((nameWithoutPrefixAndSuffix first isVowel
						and: [(nameWithoutPrefixAndSuffix beginsWith: 'Un') not])
						ifTrue: ['an']
						ifFalse: ['a']), nameWithoutPrefixAndSuffix
			classified: #visiting]
]

{ #category : #private }
XPathASTNode class >> nameWithoutPrefixAndSuffix [
	^ (self name asString allButFirst: 'XPathAST' size)
		allButLast: 'Node' size
]

{ #category : #visiting }
XPathASTNode >> acceptNodeVisitor: aNodeVisitor [
	^ self
]

{ #category : #private }
XPathASTNode >> beParentOf: aNode [
	aNode parent: self.
	^ aNode.
]

{ #category : #private }
XPathASTNode >> beParentOfAll: aNodeCollection [
	aNodeCollection do: [:each | self beParentOf: each].
	^ aNodeCollection.
]

{ #category : #private }
XPathASTNode >> defaultTypeClass [
	^ XPathObjectType
]

{ #category : #testing }
XPathASTNode >> hasParent [
	^ parent notNil
		and: [parent isNull not]
]

{ #category : #testing }
XPathASTNode >> isAbsoluteLocationPath [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAdditionExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAdditiveExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAncestorOrSelfStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAncestorStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAndExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAnyNodeTest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isArgument [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeTest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeTestForLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeTestForName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeTestForNamespaceURI [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeTestForNamespaceURIAndLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeTestForPrefix [
	^ false
]

{ #category : #testing }
XPathASTNode >> isAttributeTestForPrefixAndLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isBinaryOperatorExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isChildStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isCommentTest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isDescendantOrSelfStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isDescendantStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isDivisionExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isElementTest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isElementTestForLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isElementTestForName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isElementTestForNamespaceURI [
	^ false
]

{ #category : #testing }
XPathASTNode >> isElementTestForNamespaceURIAndLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isElementTestForPrefix [
	^ false
]

{ #category : #testing }
XPathASTNode >> isElementTestForPrefixAndLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isEqualityExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isEqualsExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isExpressionRoot [
	^ false
]

{ #category : #testing }
XPathASTNode >> isFilterExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isFilterExpressionLocationPath [
	^ false
]

{ #category : #testing }
XPathASTNode >> isFilterable [
	^ false
]

{ #category : #testing }
XPathASTNode >> isFollowingSiblingStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isFollowingStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isFunctionCall [
	^ false
]

{ #category : #testing }
XPathASTNode >> isGreaterThanExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isGreaterThanOrEqualToExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isLessThanExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isLessThanOrEqualToExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isLiteral [
	^ false
]

{ #category : #testing }
XPathASTNode >> isLocationPath [
	^ false
]

{ #category : #testing }
XPathASTNode >> isModulusExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isMultiplicationExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isMultiplicativeExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceTest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceTestForLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceTestForName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceTestForNamespaceURI [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceTestForNamespaceURIAndLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceTestForPrefix [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNamespaceTestForPrefixAndLocalName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNegationExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNodeTest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNodeWithExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNodeWithOtherExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNotEqualsExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNull [
	^ false
]

{ #category : #testing }
XPathASTNode >> isNumberLiteral [
	^ false
]

{ #category : #testing }
XPathASTNode >> isOperatorExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isOrExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isPITest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isPITestForName [
	^ false
]

{ #category : #testing }
XPathASTNode >> isParentStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isPrecedingSiblingStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isPrecedingStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isPredicate [
	^ false
]

{ #category : #testing }
XPathASTNode >> isRelationalExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isRelativeLocationPath [
	^ false
]

{ #category : #testing }
XPathASTNode >> isSelfStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isStep [
	^ false
]

{ #category : #testing }
XPathASTNode >> isStringLiteral [
	^ false
]

{ #category : #testing }
XPathASTNode >> isSubtractionExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isTextTest [
	^ false
]

{ #category : #testing }
XPathASTNode >> isUnaryOperatorExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isUnionExpression [
	^ false
]

{ #category : #testing }
XPathASTNode >> isVariableReference [
	^ false
]

{ #category : #accessing }
XPathASTNode >> parent [
	^ parent ifNil: [parent := XPathASTNullNode new]
]

{ #category : #accessing }
XPathASTNode >> parent: aParent [
	parent := aParent
]

{ #category : #accessing }
XPathASTNode >> type [
	^ type ifNil: [type := self defaultTypeClass new]
]

{ #category : #accessing }
XPathASTNode >> type: aType [
	type := aType
]
