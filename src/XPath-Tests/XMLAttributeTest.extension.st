Extension { #name : #XMLAttributeTest }

{ #category : #'*XPath-Tests' }
XMLAttributeTest >> testHasExpandedName [
	self assert: self newNode hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLAttributeTest >> testHasPrefixedNamespaceURI [
	| element namespaces |

	element := self newElementWithAttributes.
	namespaces := element namespaceScope prefixMappings values.
	element attributeNodesDo: [:each |
		"attributes can only have prefixed (non-default) attributes,
		so any namespace URI at all is a prefixed URI"
		each hasNamespaceURI
			ifTrue: [
				self assert:
					(each hasPrefixedNamespaceURI: each namespaceURI)]
			ifFalse: [
				self deny:
					(namespaces anySatisfy: [:namespace |
						each hasPrefixedNamespaceURI: namespace])]].
]

{ #category : #'*XPath-Tests' }
XMLAttributeTest >> testStringValue [
	super testStringValue.

	self assert:
		(self nodeClass
			name: 'name'
			value: 'value') stringValue = 'value'
]
