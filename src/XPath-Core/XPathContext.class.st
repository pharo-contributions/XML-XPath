"
An XPath context is used to evaluate XPath expressions. Each context has a function library and optionally also variable bindings and namespace mappings.

If no namespace mappings are present, then name tests like 'prefix:name', '*:name', and 'prefix:*' will ignore namespaces and match against node prefixes and local names while unqualified name tests will match against both unqualified names and the local parts of qualified names.
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
	^ self namespaceScope resolvePrefix: aPrefix
]

{ #category : #private }
XPathContext >> testForAnyLocalNameAfterPrefix: aPrefix [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
					"default namespaces are supposed to be ignored for this
					test, so a prefix is required"
					node isPrincipalNode
						and: [node namespaceURI = namespaceUri
							and: [node hasPrefix]]]]
		ifFalse: [
			^ [:node |
				node isPrincipalNode
					and: [node prefix = aPrefix]]]
]

{ #category : #private }
XPathContext >> testForLocalName: aLocalName [
	self hasNamespaces
		ifTrue: [
			"in this mode an unqualified name matches only another
			unqualfied name with the same local part"
			^ [:node |
					node isPrincipalNode
						and: [node name = aLocalName]]]
		ifFalse: [
			^ [:node |
				node isPrincipalNode
					and: [node localName = aLocalName]]]
]

{ #category : #private }
XPathContext >> testForPrefix: aPrefix localName: aLocalName [
	self hasNamespaces
		ifTrue: [| namespaceUri |
			namespaceUri := self resolvePrefix: aPrefix.
			^ [:node |
					"default namespaces are supposed to be ignored for this
					test, so a prefix is required"
					node isPrincipalNode
						and: [node localName = aLocalName
							and: [node namespaceURI = namespaceUri
								and: [node hasPrefix]]]]]
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
