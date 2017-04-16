"
ConfigurationOfXPath load
"
Class {
	#name : #ConfigurationOfXPath,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfXPath
}

{ #category : #'development support' }
ConfigurationOfXPath class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfXPath class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfXPath class >> catalogChangeLog [
    		
     ^ '- Development moved to Baseline 1.0.6, for ci build on pharo-contribution ci.
- Version 1.0 migrated to Pharo 3.0'


]

{ #category : #catalog }
ConfigurationOfXPath class >> catalogDescription [

	^ 'An XPath library for Pharo, Squeak, and Gemstone leveraging the XML parsing capabilities of XMLParser. Supports XPath 1.0 syntax with extensions.'
]

{ #category : #catalog }
ConfigurationOfXPath class >> catalogKeyClassesAndExample [

	^ ' ==XPath==, ==XPathContext==, and ==XPathNodeSet== are the main public classes of the package.

The following example retrieves the language types as found in the UNICODE Common Locale Data Repository (CDLR) 
[[[ 
| doc |
doc := (XMLDOMParser parseURL: ''http://unicode.org/repos/cldr/trunk/common/supplemental/supplementalData.xml'').

"get all language type attribute nodes"
(XPath for: ''//languageData/language/@type'') in: doc.

"abbreviated form"
doc // ''languageData'' / ''language'' @ ''type''
]]]'
]

{ #category : #catalog }
ConfigurationOfXPath class >> catalogKeywords [

	^ #(XPath XML DOM HTML XHTML parser web markup document query )
					
]

{ #category : #catalog }
ConfigurationOfXPath class >> catalogLicense [
	^ 'The MIT License (MIT)

Copyright (c) 2016 PharoExtras Team.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
]

{ #category : #private }
ConfigurationOfXPath class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfXPath class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfXPath class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfXPath class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfXPath class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfXPath class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfXPath class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfXPath class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline101: spec [
	<version: '1.0.1-baseline' imports: #('1.0-baseline')>
	spec for: #common do: [ spec blessing: #baseline ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.2' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline105: spec [
	<version: '1.0.5-baseline' imports: #('1.0-baseline')>
	spec for: #common do: [ spec blessing: #baseline ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.3' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline106: spec [
	<version: '1.0.6-baseline' imports: #('1.0-baseline')>
	spec for: #common do: [ spec blessing: #baseline ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.4' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XPath/main'.
		spec
			project: 'XMLParser'
			with: [ 
				spec
					className: 'ConfigurationOfXMLParser';
					versionString: #stable;
					loads: #('Core');
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
		spec
			project: 'XMLParserTests'
			copyFrom: 'XMLParser'
			with: [ spec loads: #('Tests') ].
		spec package: 'XPath-Core' with: [ spec requires: 'XMLParser' ].
		spec package: 'XPath-Tests' with: [ spec requires: #('XPath-Core' 'XMLParserTests') ].

		spec group: 'default' with: #('Core' 'Tests').
		spec group: 'Core' with: #('XPath-Core').
		spec group: 'Tests' with: #('XPath-Tests')].

	spec for: #squeakCommon do: [
		spec
			package: 'XPath-Core'
			with: [ spec includes: 'XPath-SqueakCommonCompatibility' ].
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: [ spec requires: 'XPath-Core' ]. ].

	spec for: #gemstone do: [
		spec
			package: 'XPath-Core'
			with: [ spec includes: 'XPath-GemstoneCompatibility' ].
		spec
			package: 'XPath-GemstoneCompatibility'
			with: [ spec requires: 'XPath-Core' ]. ].

	spec
		for: #gt
		do: [
			spec
				package: 'XPath-Core'
				with: [ spec includes: 'XPath-GTExtensions' ].
			spec
				package: 'XPath-GTExtensions'
				with: [ spec requires: 'XPath-Core' ]. ].
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline134: spec [
	<version: '1.3.4-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.4' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.5' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline149: spec [
	<version: '1.4.9-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.5' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.6' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline151: spec [
	<version: '1.5.1-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.5' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.7' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline155: spec [
	<version: '1.5.5-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.5' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.8' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline158: spec [
	<version: '1.5.8-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.6' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.9' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline160: spec [
	<version: '1.6.0-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.6.3' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.10' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline162: spec [
	<version: '1.6.2-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.6.3' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline163: spec [
	<version: '1.6.3-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.6.5' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline165: spec [
	<version: '1.6.5-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.6.8' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline166: spec [
	<version: '1.6.6-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.7.3' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline167: spec [
	<version: '1.6.7-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.7.4' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline168: spec [
	<version: '1.6.8-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.7.6' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline169: spec [
	<version: '1.6.9-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.1' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline170: spec [
	<version: '1.7.0-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.3' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline171: spec [
	<version: '1.7.1-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.7' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline172: spec [
	<version: '1.7.2-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.8.9' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline173: spec [
	<version: '1.7.3-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline174: spec [
	<version: '1.7.4-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.5' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline176: spec [
	<version: '1.7.6-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.7' ].
	spec for: #gemstone do: [ spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11' ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline177: spec [
	<version: '1.7.7-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.8' ].
	spec for: #gemstone do: [
		spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.11'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline177. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline180: spec [
	<version: '1.8.0-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.8' ].
	spec for: #gemstone do: [
		spec package: 'XPath-GemstoneCompatibility' with: 'XPath-GemstoneCompatibility-monty.12'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline180. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline182: spec [
	<version: '1.8.2-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.8' ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.13'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline180. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline183: spec [
	<version: '1.8.3-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.8' ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.13'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline183. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline189: spec [
	<version: '1.8.9-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.8'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.14'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline190: spec [
	<version: '1.9.0-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.8'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.15'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline191: spec [
	<version: '1.9.1-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-2.9.8'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.16'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline192: spec [
	<version: '1.9.2-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.16'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline194: spec [
	<version: '1.9.4-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.16'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ].
	spec for: #gt do: [
		spec
			package: 'XPath-GTExtensions'
			with: 'XPath-GTExtensions-monty.12'. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline198: spec [
	<version: '1.9.8-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.16'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ].
	spec for: #gt do: [
		spec
			package: 'XPath-GTExtensions'
			with: 'XPath-GTExtensions-monty.18'. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline200: spec [
	<version: '2.0.0-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.16'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ].
	spec for: #gt do: [
		spec
			package: 'XPath-GTExtensions'
			with: 'XPath-GTExtensions-monty.20'. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline201: spec [
	<version: '2.0.1-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.16'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ].
	spec for: #gt do: [
		spec
			package: 'XPath-GTExtensions'
			with: 'XPath-GTExtensions-monty.21'. ]
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline202: spec [
	<version: '2.0.2-baseline' imports: #('1.0-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec project: 'XMLParser' with: #'release-3.0.6'.
			spec postLoadDoIt: #clearXPathCache. ].
	spec for: #squeakCommon do: [
		spec
			package: 'XPath-SqueakCommonCompatibility'
			with: 'XPath-SqueakCommonCompatibility-monty.1'. ].
	spec for: #gemstone do: [
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.16'.

		"force initialization of lazy-initialized class and class isnt
		vars to avoid write conflicts on GS"
		spec postLoadDoIt: #initializeClassesForGSBaseline189. ].
	spec for: #gt do: [
		spec
			package: 'XPath-GTExtensions'
			with: 'XPath-GTExtensions-monty.24'. ]
]

{ #category : #doits }
ConfigurationOfXPath >> clearXPathCache [
	XPath clearCompiledExpressionCache
]

{ #category : #accessing }
ConfigurationOfXPath >> customProjectAttributes [
	"Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

	(Smalltalk includesKey: #GTInspector)
		ifTrue: [ ^ #(gt) ]
		ifFalse: [ ^ #() ]
]

{ #category : #'symbolic versions' }
ConfigurationOfXPath >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '2.0.2-baseline'.
]

{ #category : #doits }
ConfigurationOfXPath >> initializeClassesForGSBaseline177 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		ConfigurationOfXMLParser findLazyInitializedClassStateInPackage: 'XPath'
	"

	XPath compiledXPathCache.
	XPathCompiler systemCompilerClass.
	XPathFunction allSubclassesDo: [:each |
		each functionPrototype].
	XPathContext defaultFunctions.
	XPathNodeTestParserContext allSubclassesDo: [:each |
		each instance].
	XPathSortOrder allSubclassesDo: [:each |
		each instance].
]

{ #category : #doits }
ConfigurationOfXPath >> initializeClassesForGSBaseline180 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		ConfigurationOfXMLParser findLazyInitializedClassStateInPackage: 'XPath'
	"

	XPath compiledXPathCache.
	XPathCompiler systemCompilerClass.
	XPathFunction allSubclassesDo: [:each |
		each prototype].
	XPathContext defaultFunctions.
	XPathNodeTestParserContext allSubclassesDo: [:each |
		each instance].
	XPathSortOrder allSubclassesDo: [:each |
		each instance].
	XPathASTNullNode instance.
]

{ #category : #doits }
ConfigurationOfXPath >> initializeClassesForGSBaseline183 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		ConfigurationOfXMLParser findLazyInitializedClassStateInPackage: 'XPath'
	"

	XPath compiledXPathCache.
	XPathCompiler systemCompilerClass.
	XPathFunction allSubclassesDo: [:each |
		each prototype].
	XPathContext defaultFunctions.
	XPathNodeTestParserContext allSubclassesDo: [:each |
		each instance].
	XPathSortOrder allSubclassesDo: [:each |
		each instance].
	XPathASTNullNode instance.
	XPathType allSubclassesDo: [:each |
		each instance].
]

{ #category : #doits }
ConfigurationOfXPath >> initializeClassesForGSBaseline189 [
	"All lazily initialized class and class instance variables must be
	explicitly initialized on GS during installation to prevent write
	conflicts between Gems later on. 
	
	This can help identify classes that use lazy initialization:
		ConfigurationOfXMLParser findLazyInitializedClassStateInPackage: 'XPath'
	"

	XPath
		compiledExpressionCache;
		compiledExpressionCacheEnabled.
	XPathASTNullNode instance.
	XPathContext defaultFunctions.
	XPathExpressionCompiler systemCompilerClass.
	XPathFunction allSubclassesDo: [:each |
		each prototype].
	XPathNodeTestParserContext allSubclassesDo: [:each |
		each instance].
	XPathSortOrder allSubclassesDo: [:each |
		each instance].
	XPathType allSubclassesDo: [:each |
		each instance].
]

{ #category : #accessing }
ConfigurationOfXPath >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfXPath >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.0.2'.

]

{ #category : #versions }
ConfigurationOfXPath >> version101: spec [ 
        <version: '1.0.1' imports: #('1.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.8'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.4'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version102: spec [ 
        <version: '1.0.2' imports: #('1.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.9'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.5'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version103: spec [ 
        <version: '1.0.3' imports: #('1.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.10'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.5'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version104: spec [ 
        <version: '1.0.4' imports: #('1.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.11'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.6'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version105: spec [ 
        <version: '1.0.5' imports: #('1.0.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.12'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.7'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version106: spec [ 
        <version: '1.0.6' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.13'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.8'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version107: spec [ 
        <version: '1.0.7' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.14'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.9'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version108: spec [ 
        <version: '1.0.8' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.15'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.10'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version109: spec [ 
        <version: '1.0.9' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.16'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.11'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: ''.
		spec author: 'HernanMoralesDurand'.

		spec timestamp: '31/1/2014 21:15'.
		spec package: 'XPath' with: 'XPath-HernanMoralesDurand.12'. ].

]

{ #category : #versions }
ConfigurationOfXPath >> version110: spec [ 
        <version: '1.1.0' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.17'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.12'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version111: spec [ 
        <version: '1.1.1' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.18'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.13'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version112: spec [ 
        <version: '1.1.2' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.19'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.14'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version113: spec [ 
        <version: '1.1.3' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.20'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.15'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version114: spec [ 
        <version: '1.1.4' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.21'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.16'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version115: spec [ 
        <version: '1.1.5' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.22'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.17'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version116: spec [ 
        <version: '1.1.6' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.23'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.18'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version117: spec [ 
        <version: '1.1.7' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.24'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.19'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version118: spec [ 
        <version: '1.1.8' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.25'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.19'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version119: spec [ 
        <version: '1.1.9' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.26'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.20'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version120: spec [ 
        <version: '1.2.0' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.27'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.21'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version121: spec [ 
        <version: '1.2.1' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.28'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.22'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version122: spec [ 
        <version: '1.2.2' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.29'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.23'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version123: spec [ 
        <version: '1.2.3' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.30'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.24'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version124: spec [ 
        <version: '1.2.4' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.31'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.25'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version125: spec [ 
        <version: '1.2.5' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.32'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.26'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version126: spec [ 
        <version: '1.2.6' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.33'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.27'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version127: spec [ 
        <version: '1.2.7' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.34'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.27'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version128: spec [ 
        <version: '1.2.8' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.35'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.28'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version129: spec [ 
        <version: '1.2.9' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.36'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.29'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version130: spec [ 
        <version: '1.3.0' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.37'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.30'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version131: spec [ 
        <version: '1.3.1' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.38'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.31'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version132: spec [ 
        <version: '1.3.2' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.39'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.32'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version133: spec [ 
        <version: '1.3.3' imports: #('1.0.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.40'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.32'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version134: spec [ 
        <version: '1.3.4' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.41'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.33'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version135: spec [ 
        <version: '1.3.5' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.42'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.34'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version136: spec [ 
        <version: '1.3.6' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.43'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.35'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version137: spec [ 
        <version: '1.3.7' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.44'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.36'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version138: spec [ 
        <version: '1.3.8' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.45'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.37'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version139: spec [ 
        <version: '1.3.9' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.46'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.38'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version140: spec [ 
        <version: '1.4.0' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.48'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.38'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version141: spec [ 
        <version: '1.4.1' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.49'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.40'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version142: spec [ 
        <version: '1.4.2' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.50'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.41'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version143: spec [ 
        <version: '1.4.3' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.51'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.42'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version144: spec [ 
        <version: '1.4.4' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.52'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.43'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version145: spec [ 
        <version: '1.4.5' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.54'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.45'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version146: spec [ 
        <version: '1.4.6' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.55'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.46'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version147: spec [ 
        <version: '1.4.7' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.56'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.47'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version148: spec [ 
        <version: '1.4.8' imports: #('1.3.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.57'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.48'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version149: spec [ 
        <version: '1.4.9' imports: #('1.4.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.58'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.49'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version150: spec [ 
        <version: '1.5.0' imports: #('1.4.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.59'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.50'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version151: spec [ 
        <version: '1.5.1' imports: #('1.5.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.60'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.51'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version152: spec [ 
        <version: '1.5.2' imports: #('1.5.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.61'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.52'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version153: spec [ 
        <version: '1.5.3' imports: #('1.5.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.62'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.53'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version154: spec [ 
        <version: '1.5.4' imports: #('1.5.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.63'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.54'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version155: spec [ 
        <version: '1.5.5' imports: #('1.5.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.65'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.56'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version156: spec [ 
        <version: '1.5.6' imports: #('1.5.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.66'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.57'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version157: spec [ 
        <version: '1.5.7' imports: #('1.5.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.67'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.58'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version158: spec [ 
        <version: '1.5.8' imports: #('1.5.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.68'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.59'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version159: spec [ 
        <version: '1.5.9' imports: #('1.5.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.68'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.60'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version160: spec [ 
        <version: '1.6.0' imports: #('1.6.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.70'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.60'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version161: spec [ 
        <version: '1.6.1' imports: #('1.6.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.71'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.60'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version162: spec [ 
        <version: '1.6.2' imports: #('1.6.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.72'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.60'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version163: spec [ 
        <version: '1.6.3' imports: #('1.6.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.73'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.61'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version164: spec [ 
        <version: '1.6.4' imports: #('1.6.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.74'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.62'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version165: spec [ 
        <version: '1.6.5' imports: #('1.6.5-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.75'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.62'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version166: spec [ 
        <version: '1.6.6' imports: #('1.6.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.76'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.63'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version167: spec [ 
        <version: '1.6.7' imports: #('1.6.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.77'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.64'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version168: spec [ 
        <version: '1.6.8' imports: #('1.6.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.78'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.65'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version169: spec [ 
        <version: '1.6.9' imports: #('1.6.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.79'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.66'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version170: spec [ 
        <version: '1.7.0' imports: #('1.7.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.79'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.67'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version171: spec [ 
        <version: '1.7.1' imports: #('1.7.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.80'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.68'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version172: spec [ 
        <version: '1.7.2' imports: #('1.7.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.81'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.69'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version173: spec [ 
        <version: '1.7.3' imports: #('1.7.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.82'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.69'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version174: spec [ 
        <version: '1.7.4' imports: #('1.7.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.83'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.69'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version175: spec [ 
        <version: '1.7.5' imports: #('1.7.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.84'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.70'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version176: spec [ 
        <version: '1.7.6' imports: #('1.7.6-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.85'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.71'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version177: spec [ 
        <version: '1.7.7' imports: #('1.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.86'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.72'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version178: spec [ 
        <version: '1.7.8' imports: #('1.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.87'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.72'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version179: spec [ 
        <version: '1.7.9' imports: #('1.7.7-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.88'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.73'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version180: spec [ 
        <version: '1.8.0' imports: #('1.8.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.91'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.75'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version181: spec [ 
        <version: '1.8.1' imports: #('1.8.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.92'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.76'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version182: spec [ 
        <version: '1.8.2' imports: #('1.8.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.94'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.77'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version183: spec [ 
        <version: '1.8.3' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.95'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.78'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version184: spec [ 
        <version: '1.8.4' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.96'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.79'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version185: spec [ 
        <version: '1.8.5' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.97'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.80'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version186: spec [ 
        <version: '1.8.6' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.98'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.81'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version187: spec [ 
        <version: '1.8.7' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.99'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.82'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version188: spec [ 
        <version: '1.8.8' imports: #('1.8.3-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.100'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.83'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version189: spec [ 
        <version: '1.8.9' imports: #('1.8.9-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.102'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.84'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version190: spec [ 
        <version: '1.9.0' imports: #('1.9.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.103'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.86'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version191: spec [ 
        <version: '1.9.1' imports: #('1.9.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.104'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.88'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version192: spec [ 
        <version: '1.9.2' imports: #('1.9.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.105'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.89'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version193: spec [ 
        <version: '1.9.3' imports: #('1.9.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.107'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.90'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version194: spec [ 
        <version: '1.9.4' imports: #('1.9.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.109'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.90'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version195: spec [ 
        <version: '1.9.5' imports: #('1.9.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.110'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.90'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version196: spec [ 
        <version: '1.9.6' imports: #('1.9.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.111'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.91'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version197: spec [ 
        <version: '1.9.7' imports: #('1.9.4-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.112'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.91'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version198: spec [ 
        <version: '1.9.8' imports: #('1.9.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.113'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.92'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version199: spec [ 
        <version: '1.9.9' imports: #('1.9.8-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.114'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.92'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version200: spec [ 
        <version: '2.0.0' imports: #('2.0.0-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.116'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.92'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version201: spec [ 
        <version: '2.0.1' imports: #('2.0.1-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.117'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.92'.
                ].
]

{ #category : #versions }
ConfigurationOfXPath >> version202: spec [ 
        <version: '2.0.2' imports: #('2.0.2-baseline')>

        spec for: #common do: [
                spec blessing: #release.
			spec package: 'XPath-Core' with: 'XPath-Core-monty.118'.
			spec package: 'XPath-Tests' with: 'XPath-Tests-monty.92'.
                ].
]
