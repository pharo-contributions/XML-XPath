Extension { #name : #XMLAttributeTest }

{ #category : #'*XPath-Tests' }
XMLAttributeTest >> testHasExpandedName [
	self assert: self nodeClass new hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLAttributeTest >> testHasPrefixedNamespaceURI [
	| element namespaces |

	element := self newElementWithAttributes.
	namespaces := element namespaceScope prefixMappings values.
	element attributeNodesDo: [:each |
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
XMLAttributeTest >> testIsPrincipalNode [
	self assert: self nodeClass new isPrincipalNode
]
