Extension { #name : #XMLPITest }

{ #category : #'*XPath-Tests' }
XMLPITest >> testExpandedName [
	self assert: self newPIWithTargetAndData expandedName equals: 'target'
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testHasExpandedName [
	self assert: self newNode hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testHasNamespaceURI [
	self deny: self newPIWithTargetAndData hasNamespaceURI
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testHasPrefix [
	self deny: self newPIWithTargetAndData hasPrefix
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testLocalName [
	self assert: self newPIWithTargetAndData localName equals: 'target'
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testName [
	self assert: self newPIWithTargetAndData name equals: 'target'
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testNamespaceURI [
	self assert: self newPIWithTargetAndData namespaceURI equals: ''
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testPrefix [
	self assert: self newPIWithTargetAndData prefix equals: ''
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testStringValue [
	super testStringValue.

	self assert: self newPIWithTargetAndData stringValue equals: 'data'
]
