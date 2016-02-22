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
XPathReverseDocumentSortOrder >> on: aNodeSet attributeAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet last attributeAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				((aNodeSet at: i) attributeAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				(aNodeSet at: i)
					attributeAxisSelect: nodeTestBlock
					into: copy]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet namespaceAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet last namespaceAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				((aNodeSet at: i) namespaceAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				(aNodeSet at: i)
					namespaceAxisSelect: nodeTestBlock
					into: copy]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet parentAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy "parent is a document order axis according to the spec"
		sortOrder: XPathDocumentSortOrder new;
		filterEachInSeparateContextWithAll:
			aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> on: aNodeSet selfAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTestBlock
			into: copy].
	^ copy
		sortOrder: XPathDocumentSortOrder new;
		filterEachInSeparateContextWithAll:
			aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters.
]
