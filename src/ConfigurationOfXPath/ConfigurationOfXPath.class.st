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
ConfigurationOfXPath class >> catalogContactInfo [
	^ 'hernan.morales@gmail.com'
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
(XPath for: ''//languageData/language/@type'') in: doc.
]]]'
]

{ #category : #catalog }
ConfigurationOfXPath class >> catalogKeywords [
	^ #(XPath XML DOM HTML web query parsing)
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

	spec for: #gemstone do: [
		spec blessing: #baseline.
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.2'. ].
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline105: spec [
	<version: '1.0.5-baseline' imports: #('1.0-baseline')>

	spec for: #gemstone do: [
		spec blessing: #baseline.
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.3'. ].
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline106: spec [
	<version: '1.0.6-baseline' imports: #('1.0-baseline')>

	spec for: #gemstone do: [
		spec blessing: #baseline.
		spec
			package: 'XPath-GemstoneCompatibility'
			with: 'XPath-GemstoneCompatibility-monty.4'. ].
]

{ #category : #baselines }
ConfigurationOfXPath >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XPath/main'.
		spec project: 'XMLParser' with: [ 
			spec
				className: 'ConfigurationOfXMLParser';
				loads: #('default');	
				versionString: #'stable';
				repository: 'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main' ].
		spec package: 'XPath-Core' with: [ spec requires: 'XMLParser' ].
		spec package: 'XPath-Tests' with: [ spec requires: 'XPath-Core' ].

		spec group: 'default' with: #('Core' 'Tests').
		spec group: 'Core' with: #('XPath-Core').
		spec group: 'Tests' with: #('XPath-Tests'). ].

	"load gemstone methods"
	spec for: #'gemstone' do: [
		spec
			package: 'XPath-Core'
			with: [ spec includes: 'XPath-GemstoneCompatibility' ].
		spec
			package: 'XPath-GemstoneCompatibility'
			with: [ spec requires: 'XPath-Core' ]. ].
]

{ #category : #accessing }
ConfigurationOfXPath >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfXPath >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.0.6-baseline'.
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

	spec for: #'common' version: '1.1.9'.

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
