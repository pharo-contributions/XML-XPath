Extension { #name : #Number }

{ #category : #'*XPath-GemstoneCompatibility' }
Number >> asXPathString [
	self isNaN
		ifTrue: [^ 'NaN'].
	self isZero
		ifTrue: [^ '0'].
	self isInfinite
		ifTrue: [
			self < 0
				ifTrue: [^ '-Infinity']
				ifFalse: [^ 'Infinity']].
	^ self greaseString.
]
