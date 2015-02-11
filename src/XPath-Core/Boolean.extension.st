Extension { #name : #Boolean }

{ #category : #'*XPath-Core' }
Boolean >> /!=/ anObject [
	^ anObject xPathNotEqualsBoolean: self
]

{ #category : #'*XPath-Core' }
Boolean >> /*/ anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> /+/ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> /-/ anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> /</ anObject [
	^ anObject xPathGreaterThanBoolean: self
]

{ #category : #'*XPath-Core' }
Boolean >> /<=/ anObject [
	^ (anObject xPathGreaterThanBoolean: self)
		or: [anObject xPathEqualsBoolean: self]
]

{ #category : #'*XPath-Core' }
Boolean >> /=/ anObject [
	^ anObject xPathEqualsBoolean: self
]

{ #category : #'*XPath-Core' }
Boolean >> />/ anObject [
	^ anObject xPathLessThanBoolean: self
]

{ #category : #'*XPath-Core' }
Boolean >> />=/ anObject [
	^ (anObject xPathLessThanBoolean: self)
		or: [anObject xPathEqualsBoolean: self]
]

{ #category : #'*XPath-Core' }
Boolean >> /\\/ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> asXPathBoolean [
	^ self
]

{ #category : #'*XPath-Core' }
Boolean >> asXPathNumber [
	self subclassResponsibility
]

{ #category : #'*XPath-Core' }
Boolean >> asXPathString [
	self subclassResponsibility
]

{ #category : #'*XPath-Core' }
Boolean >> xPathEqualsBoolean: aBoolean [
	^ self = aBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathEqualsNodeSet: aNodeSet [
	^ self = aNodeSet asXPathBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathEqualsNumber: aNumber [
	^ self = aNumber asXPathBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathEqualsString: aString [
	^ self = aString asXPathBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathGreaterThanBoolean: aBoolean [
	^ self asXPathNumber > aBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> xPathGreaterThanNodeSet: aNodeSet [
	^ self asXPathNumber > aNodeSet asXPathBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> xPathGreaterThanNumber: aNumber [
	^ self asXPathNumber > aNumber asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> xPathGreaterThanString: aString [
	^ self asXPathNumber > aString asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> xPathLessThanBoolean: aBoolean [
	^ self asXPathNumber < aBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> xPathLessThanNodeSet: aNodeSet [
	^ self asXPathNumber < aNodeSet asXPathBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> xPathLessThanNumber: aNumber [
	^ self asXPathNumber < aNumber asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean >> xPathLessThanString: aString [
	^ self asXPathNumber < aString asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean class >> xPathNewFrom: anObject [
	^ anObject asXPathBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathNotEqualsBoolean: aBoolean [
	^ self ~= aBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathNotEqualsNodeSet: aNodeSet [
	^ self ~= aNodeSet asXPathBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathNotEqualsNumber: aNumber [
	^ self ~= aNumber asXPathBoolean
]

{ #category : #'*XPath-Core' }
Boolean >> xPathNotEqualsString: aString [
	^ self ~= aString asXPathBoolean
]
