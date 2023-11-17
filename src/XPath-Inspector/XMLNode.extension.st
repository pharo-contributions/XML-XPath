Extension { #name : #XMLNode }

{ #category : #'*XPath-Inspector' }
XMLNode >> inspectXPathIn: specBuilder [

	<inspectorPresentationOrder: 35 title: 'XPath'>
	self supportsXPathEvaluator ifFalse: [ ^ self ].

	^ specBuilder newCode
		  withoutSyntaxHighlight;
		  overridingContextMenu;
		  text: 'self::node()';
		  whenSubmitDo: [ :text | (self xpath: text asString) inspect ]
]

{ #category : #'*XPath-Inspector' }
XMLNode >> supportsXPathEvaluator [
	^ true
]
