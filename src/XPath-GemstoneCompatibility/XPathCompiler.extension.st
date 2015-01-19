Extension { #name : #XPathCompiler }

{ #category : #'*XPath-GemstoneCompatibility' }
XPathCompiler >> compileSource: aString [
	^ aString evaluate
]
