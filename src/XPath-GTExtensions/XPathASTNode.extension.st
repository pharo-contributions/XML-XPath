Extension { #name : #XPathASTNode }

{ #category : #'*XPath-GTExtensions' }
XPathASTNode >> asHighlightedText [
	^ XPathHighlightingASTSourceWritingNodeVisitor new
		visitNode: self;
		asHighlightedText
]

{ #category : #'*XPath-GTExtensions' }
XPathASTNode >> gtInspectorSourceIn: aComposite [
	<gtInspectorPresentationOrder: 6>

	aComposite text
		title: 'Source';
		format: [self asHighlightedText]
]

{ #category : #'*XPath-GTExtensions' }
XPathASTNode >> gtInspectorTreeIn: aComposite [
	<gtInspectorPresentationOrder: 5>

	aComposite tree
		title: 'Tree';
		display: [{self}];
		children: [:each | each treeViewChildren];
		format: [:each | each treeViewLabelText];
		when: [self supportsTreeView];
		rootsExpanded
]

{ #category : #'*XPath-GTExtensions' }
XPathASTNode >> printTreeViewLabelOn: aStream [
	aStream nextPutAll: self class name asString
]

{ #category : #'*XPath-GTExtensions' }
XPathASTNode >> supportsTreeView [
	^ false
]

{ #category : #'*XPath-GTExtensions' }
XPathASTNode >> treeViewChildren [
	^ #()
]

{ #category : #'*XPath-GTExtensions' }
XPathASTNode >> treeViewLabelText [
	| writeStream |

	writeStream := (String new: 100) writeStream.
	self printTreeViewLabelOn: writeStream.
	^ writeStream contents asText.
]
