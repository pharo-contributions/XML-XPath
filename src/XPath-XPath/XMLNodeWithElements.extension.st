Extension { #name : #XMLNodeWithElements }

{ #category : #'*XPath' }
XMLNodeWithElements >> addEntity: entityName value: entityValue [
	self entities add: entityName->entityValue
]

{ #category : #'*XPath' }
XMLNodeWithElements >> namespace [
	^ namespace

]

{ #category : #'*XPath' }
XMLNodeWithElements >> namespace: ns uri: u [
	namespace := ns.
	uri := u

]

{ #category : #'*XPath' }
XMLNodeWithElements >> namespaceURI [
	^ uri

]
