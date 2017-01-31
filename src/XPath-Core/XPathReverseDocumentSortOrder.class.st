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
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathAttributeNodeTestBlock.
	copy := (aNodeSet at: aNodeSet size) attributeAxis: nodeTestBlock.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			attributeAxisSelect: nodeTestBlock
			into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathAttributeNodeTestBlock.
	copy :=
		(aNodeSet at: aNodeSet size)
			attributeAxis: nodeTestBlock
			predicates: aPredicateCollection.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		((aNodeSet at: i)
			attributeAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNamespaceNodeTestBlock.
	copy := (aNodeSet at: aNodeSet size) namespaceAxis: nodeTestBlock.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			namespaceAxisSelect: nodeTestBlock
			into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNamespaceNodeTestBlock.
	copy :=
		(aNodeSet at: aNodeSet size)
			namespaceAxis: nodeTestBlock
			predicates: aPredicateCollection.
	aNodeSet size - 1 to: 1 by: -1 do: [:i |
		((aNodeSet at: i)
			namespaceAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet parentAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	"parent is a document order axis according to the spec"
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet selfAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTestBlock
			into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]
