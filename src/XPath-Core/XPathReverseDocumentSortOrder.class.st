"
A sort order for nodes in reverse document order.
"
Class {
	#name : #XPathReverseDocumentSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #converting }
XPathReverseDocumentSortOrder >> asReversedSortOrder [
	^ XPathDocumentSortOrder new
]

{ #category : #sorting }
XPathReverseDocumentSortOrder >> documentOrderSort: aNodeSet [
	aNodeSet reverseInPlace
]

{ #category : #accessing }
XPathReverseDocumentSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	^ aNodeSet last
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock [
	| copy attributeAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	attributeAxisNodeTest := aNodeTestStringOrBlock asXPathAttributeAxisNodeTest.
	copy := (aNodeSet at: aNodeSet size) attributeAxis: attributeAxisNodeTest.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			attributeAxisSelect: attributeAxisNodeTest
			into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy attributeAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	attributeAxisNodeTest := aNodeTestStringOrBlock asXPathAttributeAxisNodeTest.
	copy :=
		(aNodeSet at: aNodeSet size)
			attributeAxis: attributeAxisNodeTest
			predicates: aPredicateCollection.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		((aNodeSet at: i)
			attributeAxis: attributeAxisNodeTest
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock [
	| copy namespaceAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	namespaceAxisNodeTest := aNodeTestStringOrBlock asXPathNamespaceAxisNodeTest.
	copy := (aNodeSet at: aNodeSet size) namespaceAxis: namespaceAxisNodeTest.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			namespaceAxisSelect: namespaceAxisNodeTest
			into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy namespaceAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	namespaceAxisNodeTest := aNodeTestStringOrBlock asXPathNamespaceAxisNodeTest.
	copy :=
		(aNodeSet at: aNodeSet size)
			namespaceAxis: namespaceAxisNodeTest
			predicates: aPredicateCollection.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		((aNodeSet at: i)
			namespaceAxis: namespaceAxisNodeTest
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet parentAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTest
			ifNotPresentInto: copy].
	"parent is a document order axis according to the spec"
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet selfAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTest
			into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]
