"
An XPath context is used to evaluate XPath expressions. Each context has a function library and optionally also variable bindings and namespace mappings.

If no namespace mappings are set, then name tests like 'prefix:name', '*:name', and 'prefix:*' will match against the name part(s) directly with wildcards matching any name part.
"
Class {
	#name : #XPathContext,
	#superclass : #Object,
	#instVars : [
		'variables',
		'functions',
		'namespaceScope',
		'functionStack'
	],
	#classInstVars : [
		'defaultFunctions'
	],
	#category : #'XPath-Core'
}

{ #category : #accessing }
XPathContext class >> defaultFunctions [
	^ defaultFunctions ifNil: [defaultFunctions := XPathFunctionSet default]
]

{ #category : #accessing }
XPathContext class >> defaultFunctions: aFunctionSet [
	defaultFunctions := aFunctionSet
]

{ #category : #'instance creation' }
XPathContext class >> functions: aFunctionSet [
	^ self new functions: aFunctionSet
]

{ #category : #'instance creation' }
XPathContext class >> namespaces: anAssociationCollection [
	^ self new declareNamespaces: anAssociationCollection
]

{ #category : #'instance creation' }
XPathContext class >> variables: anAssociationCollection [
	^ self new variables: anAssociationCollection
]

{ #category : #'instance creation' }
XPathContext class >> variables: aVariableAssociationCollection namespaces: aNamepsaceAssociationCollection [
	^ self new
		variables: aVariableAssociationCollection;
		declareNamespaces: aNamepsaceAssociationCollection
]

{ #category : #'instance creation' }
XPathContext class >> variables: aVariableAssociationCollection namespaces: aNamepsaceAssociationCollection functions: aFunctionSet [
	^ self new
		variables: aVariableAssociationCollection;
		declareNamespaces: aNamepsaceAssociationCollection;
		functions: aFunctionSet
]

{ #category : #accessing }
XPathContext >> addFunction: aFunction [
	functions := self functions + aFunction
]

{ #category : #namespaces }
XPathContext >> declareNamespaces: anAssociationCollection [
	self namespaceScope mapPrefixesAndURIs: anAssociationCollection
]

{ #category : #namespaces }
XPathContext >> declarePrefix: aPrefix uri: aUri [
	self namespaceScope
		mapPrefix: aPrefix
		to: aUri
]

{ #category : #private }
XPathContext >> errorUndeclaredFunction: aFunctionName [
	XPathUndeclaredFunctionException
		formatSignal: 'Undeclared function {1}()'
		with: aFunctionName
]

{ #category : #private }
XPathContext >> errorUndeclaredVariable: aVariableName [
	XPathUndeclaredVariableException
		formatSignal: 'Undeclared variable reference ${1}'
		with: aVariableName
]

{ #category : #namespaces }
XPathContext >> errorUnmappedPrefix: aPrefix [
	XPathUndeclaredPrefixException
		formatSignal: 'Prefix "{1}" was not mapped in XPath context'
		with: aPrefix
]

{ #category : #private }
XPathContext >> function: aFunctionName contextNode: aContextNode [
	^ (self functions
		functionNamed: aFunctionName
		ifAbsent: [self errorUndeclaredFunction: aFunctionName])
		context: self
		contextNode: aContextNode
]

{ #category : #private }
XPathContext >> functions [
	^ functions ifNil: [functions := self class defaultFunctions]
]

{ #category : #accessing }
XPathContext >> functions: aFunctionSet [
	functions := aFunctionSet
]

{ #category : #testing }
XPathContext >> hasNamespaces [
	^ namespaceScope notNil
		and: [namespaceScope hasNamespaces]
]

{ #category : #testing }
XPathContext >> includesFunction: aFunction [
	^ self functions includes: aFunction
]

{ #category : #testing }
XPathContext >> includesVariable: aVariableName [
	^ self variables includesKey: aVariableName
]

{ #category : #initialization }
XPathContext >> initialize [
	super initialize.
	functionStack := OrderedCollection new.
]

{ #category : #testing }
XPathContext >> isDeclaredPrefix: aPrefix [
	^ self namespaceScope includesPrefix: aPrefix
]

{ #category : #testing }
XPathContext >> isDeclaredPrefix: aPrefix uri: aUri [
	^ self namespaceScope includesPrefix: aPrefix mappedTo: aUri
]

{ #category : #private }
XPathContext >> namespaceScope [
	^ namespaceScope ifNil: [namespaceScope := XMLNamespaceScope new]
]

{ #category : #private }
XPathContext >> pop [
	^ functionStack removeLast
]

{ #category : #namespaces }
XPathContext >> prefixOfNamespaceURI: aNamespaceUri [
	^ self namespaceScope prefixMappings
		keyAtValue: aNamespaceUri
		ifAbsent: ['']
]

{ #category : #private }
XPathContext >> push: anObject [
	^ functionStack addLast: anObject
]

{ #category : #accessing }
XPathContext >> removeFunction: aFunction [
	functions := self functions - aFunction
]

{ #category : #namespaces }
XPathContext >> resolvePrefix: aPrefix [
	^ self namespaceScope
		resolvePrefix: aPrefix
		ifUnresolvable: [self errorUnmappedPrefix: aPrefix]
]

{ #category : #private }
XPathContext >> testForAttributeWithPrefix: aPrefix [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
				node isAttribute
					and: [node hasPrefixedNamespaceURI: namespaceUri]]]
		ifFalse: [
			^ [:node |
				node isAttribute
					and: [node prefix = aPrefix]]]
]

{ #category : #private }
XPathContext >> testForAttributeWithPrefix: aPrefix localName: aLocalName [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
				node isAttribute
					and: [node localName = aLocalName
						and: [node hasPrefixedNamespaceURI: namespaceUri]]]]
		ifFalse: [| name |
			name := aLocalName qualifyWithPrefix: aPrefix.
			^ [:node |
				node isAttribute
					and: [node name = name]]]
]

{ #category : #private }
XPathContext >> testForElementWithPrefix: aPrefix [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
				node isElement
					and: [node hasPrefixedNamespaceURI: namespaceUri]]]
		ifFalse: [
			^ [:node |
				node isElement
					and: [node prefix = aPrefix]]]
]

{ #category : #private }
XPathContext >> testForElementWithPrefix: aPrefix localName: aLocalName [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
				node isElement
					and: [node localName = aLocalName
						and: [node hasPrefixedNamespaceURI: namespaceUri]]]]
		ifFalse: [| name |
			name := aLocalName qualifyWithPrefix: aPrefix.
			^ [:node |
				node isElement
					and: [node name = name]]]
]

{ #category : #private }
XPathContext >> testForPrefix: aPrefix [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
				node isPrincipalNode
					and: [node hasPrefixedNamespaceURI: namespaceUri]]]
		ifFalse: [
			^ [:node |
				node isPrincipalNode
					and: [node prefix = aPrefix]]]
]

{ #category : #private }
XPathContext >> testForPrefix: aPrefix localName: aLocalName [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
				node isPrincipalNode
					and: [node localName = aLocalName
						and: [node hasPrefixedNamespaceURI: namespaceUri]]]]
		ifFalse: [| name |
			name := aLocalName qualifyWithPrefix: aPrefix.
			^ [:node |
				node isPrincipalNode
					and: [node name = name]]]
]

{ #category : #namespaces }
XPathContext >> undeclarePrefix: aPrefix [
	self namespaceScope unmapPrefix: aPrefix
]

{ #category : #accessing }
XPathContext >> variableAt: aVariableName [
	^ self variables
		at: aVariableName
		ifAbsent: [self errorUndeclaredVariable: aVariableName]
]

{ #category : #accessing }
XPathContext >> variableAt: aVariableName ifAbsent: aBlock [
	^ self variables
		at: aVariableName
		ifAbsent: aBlock
]

{ #category : #accessing }
XPathContext >> variableAt: aVariableName ifAbsentPut: aBlock [
	^ self variables
		at: aVariableName
		ifAbsentPut: aBlock
]

{ #category : #accessing }
XPathContext >> variableAt: aVariableName put: aValue [
	^ self variables
		at: aVariableName
		put: aValue
]

{ #category : #private }
XPathContext >> variables [
	^ variables ifNil: [variables := Dictionary new]
]

{ #category : #accessing }
XPathContext >> variables: anAssociationCollection [
	variables :=
		anAssociationCollection isDictionary
			ifTrue: [anAssociationCollection]
			ifFalse: [Dictionary withAll: anAssociationCollection]
]
