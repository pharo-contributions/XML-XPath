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

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> attributeAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet last @ aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				((aNodeSet at: i) @ aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				(aNodeSet at: i)
					attributeAxisSelect: nodeTestBlock
					into: copy]].
	^ copy sortOrder: XPathDocumentSortOrder new.
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
XPathReverseDocumentSortOrder >> namespaceAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet last @@ aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				((aNodeSet at: i) @@ aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				(aNodeSet at: i)
					namespaceAxisSelect: nodeTestBlock
					into: copy]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> parentAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy "parent is a document order axis according to the spec"
		sortOrder: XPathDocumentSortOrder new;
		filterEachInSeparateContextWithAll:
			aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> selfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	aNodeSet size to: 1 by: -1 do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTestBlock
			into: copy].
	^ copy
		sortOrder: XPathDocumentSortOrder new;
		filterEachInSeparateContextWithAll:
			aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]
