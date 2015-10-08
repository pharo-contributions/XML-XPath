"
A sort order for nodes in reverse document order.
"
Class {
	#name : #XPathReverseDocumentSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> attributeAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := aNodeSet last @ aStringOrBlockOrNodeTestWithFilters.
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				copy addAll: (aNodeSet at: i) @ aStringOrBlockOrNodeTestWithFilters].
			^ copy sortOrder: XPathDocumentSortOrder new]
		ifFalse: [^ aNodeSet copyEmpty].
]

{ #category : #sorting }
XPathReverseDocumentSortOrder >> documentOrderSort: aNodeSet [
	aNodeSet
		reverseInPlace;
		sortOrder: XPathDocumentSortOrder new
]

{ #category : #accessing }
XPathReverseDocumentSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	^ aNodeSet last
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> namespaceAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := aNodeSet last @@ aStringOrBlockOrNodeTestWithFilters.
			aNodeSet size - 1 to: 1 by: -1 do: [:i |
				copy addAll: (aNodeSet at: i) @@ aStringOrBlockOrNodeTestWithFilters].
			^ copy sortOrder: XPathDocumentSortOrder new]
		ifFalse: [^ aNodeSet copyEmpty].
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> parentAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy nodeTestBlock |
			copy := aNodeSet copyEmpty.
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			aNodeSet reverseDo: [:each | | parent |
				((parent := each parent) notNil
					and: [(nodeTestBlock value: parent)
						and: [(copy includes: parent) not]])
					ifTrue: [copy addLast: parent]].
			"parent is a document order axis according to the spec"
			^ copy
				sortOrder: XPathDocumentSortOrder new;
				filterEachInSeparateContextWithAll:
					aStringOrBlockOrNodeTestWithFilters asNodeSetFilters]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathReverseDocumentSortOrder >> selfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy nodeTestBlock |
			copy := aNodeSet copyEmpty.
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			aNodeSet reverseDo: [:each |
				(nodeTestBlock value: each)
					ifTrue: [copy addLast: each]].
			^ copy
				sortOrder: XPathDocumentSortOrder new;
				filterEachInSeparateContextWithAll:
					aStringOrBlockOrNodeTestWithFilters asNodeSetFilters]
		ifFalse: [^ aNodeSet copyEmpty]
]
