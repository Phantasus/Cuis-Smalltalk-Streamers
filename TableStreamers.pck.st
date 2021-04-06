'From Cuis 5.0 [latest update: #4526] on 6 April 2021 at 1:15:49 pm'!
'Description Provides different stream based readers for simple tabular data for TSV, CSV or other formats which look similiar to those formats.

Author: Josef Philip Bernhart (jpb)
License: MIT'!
!provides: 'TableStreamers' 1 4!
SystemOrganization addCategory: 'TableStreamers-Tests'!
SystemOrganization addCategory: 'TableStreamers'!


!classDefinition: #TableCsvReaderTest category: 'TableStreamers-Tests'!
TestCase subclass: #TableCsvReaderTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers-Tests'!
!classDefinition: 'TableCsvReaderTest class' category: 'TableStreamers-Tests'!
TableCsvReaderTest class
	instanceVariableNames: ''!

!classDefinition: #TableLineReaderTest category: 'TableStreamers-Tests'!
TestCase subclass: #TableLineReaderTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers-Tests'!
!classDefinition: 'TableLineReaderTest class' category: 'TableStreamers-Tests'!
TableLineReaderTest class
	instanceVariableNames: ''!

!classDefinition: #TableRecordReaderTest category: 'TableStreamers-Tests'!
TestCase subclass: #TableRecordReaderTest
	instanceVariableNames: 'usedClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers-Tests'!
!classDefinition: 'TableRecordReaderTest class' category: 'TableStreamers-Tests'!
TableRecordReaderTest class
	instanceVariableNames: ''!

!classDefinition: #TableArrayRecordBuilder category: 'TableStreamers'!
Object subclass: #TableArrayRecordBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableArrayRecordBuilder class' category: 'TableStreamers'!
TableArrayRecordBuilder class
	instanceVariableNames: ''!

!classDefinition: #TableDictionaryRecordBuilder category: 'TableStreamers'!
Object subclass: #TableDictionaryRecordBuilder
	instanceVariableNames: 'fieldConverter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableDictionaryRecordBuilder class' category: 'TableStreamers'!
TableDictionaryRecordBuilder class
	instanceVariableNames: ''!

!classDefinition: #TableFieldConverter category: 'TableStreamers'!
Object subclass: #TableFieldConverter
	instanceVariableNames: 'detectNumbers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableFieldConverter class' category: 'TableStreamers'!
TableFieldConverter class
	instanceVariableNames: ''!

!classDefinition: #TableFieldsProcessor category: 'TableStreamers'!
Object subclass: #TableFieldsProcessor
	instanceVariableNames: 'fields field fieldsIndex fieldIndex fieldStart fieldEnd fieldNames insideFieldState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableFieldsProcessor class' category: 'TableStreamers'!
TableFieldsProcessor class
	instanceVariableNames: ''!

!classDefinition: #TableLineProcessor category: 'TableStreamers'!
Object subclass: #TableLineProcessor
	instanceVariableNames: 'lineBuffer lineIndex lineNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableLineProcessor class' category: 'TableStreamers'!
TableLineProcessor class
	instanceVariableNames: ''!

!classDefinition: #TableStreamReader category: 'TableStreamers'!
Object subclass: #TableStreamReader
	instanceVariableNames: 'readStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableStreamReader class' category: 'TableStreamers'!
TableStreamReader class
	instanceVariableNames: ''!

!classDefinition: #TableLineReader category: 'TableStreamers'!
TableStreamReader subclass: #TableLineReader
	instanceVariableNames: 'crChar lineFeedChar lineBuffer lineIndex lineNumber lineProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableLineReader class' category: 'TableStreamers'!
TableLineReader class
	instanceVariableNames: ''!

!classDefinition: #TableRecordReader category: 'TableStreamers'!
TableStreamReader subclass: #TableRecordReader
	instanceVariableNames: 'delimiter fieldsProcessor recordBuilder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'TableRecordReader class' category: 'TableStreamers'!
TableRecordReader class
	instanceVariableNames: ''!

!classDefinition: #CsvReader category: 'TableStreamers'!
TableRecordReader subclass: #CsvReader
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TableStreamers'!
!classDefinition: 'CsvReader class' category: 'TableStreamers'!
CsvReader class
	instanceVariableNames: ''!


!TableArrayRecordBuilder commentStamp: '<historical>' prior: 0!
Builds a new record so that it is like a ordered collection of fields!

!TableDictionaryRecordBuilder commentStamp: '<historical>' prior: 0!
Builds a new record so that it is like a dictionary!

!TableFieldsProcessor commentStamp: '<historical>' prior: 0!
A processor for holding fields.!

!TableLineProcessor commentStamp: '<historical>' prior: 0!
Processor of a line. A glorified linebuffer.!

!TableRecordReader commentStamp: '<historical>' prior: 0!
Reader for simple records. These are separated by a delimiter. TSV (tab separated values) are an example of such a file format!

!CsvReader commentStamp: '<historical>' prior: 0!
A reader for the CSV (comma separated value) format, which is an overcomplicated format for reading records in!

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:05:37'!
newLines: aCollection
	| newLine |
	newLine _ String newLineString.
	
	^(newLine join: aCollection)! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 20:58:00'!
setUp
	usedClass _ CsvReader! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 20:59:59'!
testReadingEmptyLine
	| reader |
	
	reader _ usedClass on: '' readStream.
	self assert: #() equals: reader nextRecord.! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:35:06'!
testReadingLinesWithAHeader
	| reader lines record1 record2 record3 |
	
	lines _ {
		'"firstname","lastname","username"'.
		'"Dagobert","Duck","scrooge"'.
		'"Donald","Duck","ducky1"'.
	}.
	
	reader _ usedClass on:  (self newLines: lines) readStream.
	reader recordBuilder: TableDictionaryRecordBuilder new.

	self assert: nil equals: reader headers.

	record1 _ Dictionary new.
	record1 at: 'firstname' put: 'firstname'.
	record1 at: 'lastname' put: 'lastname'.
	record1 at: 'username' put: 'username'.

	self assert: record1 equals: reader nextRecord.
	self assert: #('firstname' 'lastname' 'username') equals: reader headers.
	
	record2 _ Dictionary new.
	record2 at: 'firstname' put: 'Dagobert'.
	record2 at: 'lastname' put: 'Duck'.
	record2 at: 'username' put: 'scrooge'.
	
	self assert: record2 equals: reader nextRecord.
		
	record3 _ Dictionary new.
	record3 at: 'firstname' put: 'Donald'.
	record3 at: 'lastname' put: 'Duck'.
	record3 at: 'username' put: 'ducky1'.
		
	self assert: record3 equals: reader nextRecord.
	
	self assert: reader atEnd.! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:05:30'!
testReadingLinesWithCommasInFields
	| reader lines |
	
	lines _ #(
		'"name","cheese,beacon,sandwhich","value"'
		'"chedar","yes","13.0"'
	).
	
	reader _ usedClass on: (self newLines: lines) readStream.
	self assert: #('name' 'cheese,beacon,sandwhich' 'value') equals: reader nextRecord.
	self assert: #('chedar' 'yes' '13.0') equals: reader nextRecord.! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:12:17'!
testReadingSimpleLine
	| reader |
	
	reader _ usedClass on: '"name","firstName",,"lastName"' readStream.
	self assert: #('name' 'firstName' '' 'lastName') equals: reader nextRecord.! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:10:27'!
testReadingSimpleLines
	| reader lines |
	
	lines _ #(
		'"name","cheese","value"'
		'"chedar","yes","13.0"'
	).
	
	reader _ usedClass on: (self newLines: lines) readStream.
	self assert: #('name' 'cheese' 'value') equals: reader nextRecord.
	self assert: #('chedar' 'yes' '13.0') equals: reader nextRecord.! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:23:45'!
testReadingUnquotedLines
	| reader lines |
	
	lines _ #(
		'name,cheese,value'
		'chedar,yes,13.0'
	).
	
	reader _ usedClass on: (self newLines: lines) readStream.
	self assert: #('name' 'cheese' 'value') equals: reader nextRecord.
	self assert: #('chedar' 'yes' '13.0') equals: reader nextRecord.! !

!TableCsvReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 10:42:44'!
testReadingUpToEnd
	| reader lines actual |
	
	lines _ #(
		'"name","cheese,beacon,sandwhich","value"'
		'"chedar","yes","13.0"'
	).
	
	reader _ usedClass on: (self newLines: lines) readStream.
	actual _ reader upToEnd.
	
	self assert: #('name' 'cheese,beacon,sandwhich' 'value') equals: (actual at: 1).
	self assert: #('chedar' 'yes' '13.0') equals: (actual at: 2).! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 10:23:39'!
newCRLFLines: collection
	^String crlfString join: collection! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 10:24:09'!
newCRLines: collection
	^String crString join: collection! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 10:24:02'!
newLFLines: collection
	^String lfString join: collection! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/18/2020 16:10:38'!
setUp
	usedClass _ TableLineReader ! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/18/2020 16:10:38'!
testReadingCRBasedLines
	| reader |
	
	reader _ TableLineReader on: (self newCRLines: #('but' 'this' 'is' 'ok')) readStream.
		
	self assert: 'but' equals: reader next.
	self assert: 'this' equals: reader next.
	self assert: 'is' equals: reader next.
	self assert: 'ok' equals: reader next.! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/18/2020 16:10:38'!
testReadingCRLFLines
	| reader |
	
	reader _ TableLineReader on: (self newCRLFLines: #('this' 'is' 'msdos')) readStream.
		
	self assert: 'this' equals: reader next.
	self assert: 'is' equals: reader next.
	self assert: 'msdos' equals: reader next.	! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 18:42:46'!
testReadingEmptyLine
	| expected reader |
	
	reader _ usedClass on: '' readStream.
	expected _ ''.

	self assert: expected equals: reader next.
	self assert: reader atEnd! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/18/2020 16:10:38'!
testReadingLFLines
	| reader |
	
	reader _ TableLineReader on: (self newLFLines: #('this' 'is' 'on' 'unix')) readStream.
		
	self assert: 'this' equals: reader next.
	self assert: 'is' equals: reader next.
	self assert: 'on' equals: reader next.
	self assert: 'unix' equals: reader next.	! !

!TableLineReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 10:28:46'!
testTheSetup
	"Test the testcase utility methods"
	| lines crString lfString crLfString expectedString |
	crString _ String crString.
	lfString _ String lfString.
	crLfString _ String crlfString.
	
	lines _ self newCRLFLines: #('a' 'b' 'c').
	expectedString _ 	'a' , crLfString , 'b' , crLfString , 'c'.
	self assert: lines equals: expectedString.
	
	lines _ self newCRLines: #('d' 'e' 'f').
	expectedString _ 'd' , crString , 'e' , crString , 'f'.
	self assert: lines equals: expectedString.
	
	lines _ self newLFLines: #('g' 'h' 'i').
	expectedString _ 'g' , lfString , 'h' , lfString , 'i'.
	self assert: lines equals: expectedString.! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 19:14:16'!
newLFLines: collection
	^String lfString join: collection! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 19:19:29'!
newLines: collection
	^'' join: collection! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 09:14:08'!
newRecord: aCollection
	| tab newLine |
	tab _ String tab.
	newLine _ String newLineString.
	
	^(tab join: aCollection) , newLine.! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/18/2020 16:11:36'!
setUp
	usedClass _ TableRecordReader ! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 10:52:08'!
testCreatingWithStream
	| reader |
	
	reader _ usedClass on: '' readStream.
	self assert: #() equals: reader nextRecord.
	
	reader _ usedClass on:  (self newRecord: #('a' 'b' 'c' 'd')) readStream.
	self assert: #('a' 'b' 'c' 'd') equals: reader nextRecord.! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 19:14:57'!
testReadingEmptyLine
	| reader |
	
	reader _ usedClass on: '' readStream.
	self assert: #() equals: reader nextRecord.
	! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:32:34'!
testReadingLinesWithAHeader
	| reader lines record1 record2 record3 |
	
	lines _ {
		self newRecord: #('firstname' 'lastname' 'username').
		self newRecord: #('Dagobert' 'Duck' 'scrooge').
		self newRecord: #('Donald' 'Duck' 'ducky1').
	}.
	
	reader _ usedClass on:  (self newLines: lines) readStream.
	reader recordBuilder: TableDictionaryRecordBuilder new.

	self assert: nil equals: reader headers.

	record1 _ Dictionary new.
	record1 at: 'firstname' put: 'firstname'.
	record1 at: 'lastname' put: 'lastname'.
	record1 at: 'username' put: 'username'.

	self assert: record1 equals: reader nextRecord.
	self assert: #('firstname' 'lastname' 'username') equals: reader headers.
	
	record2 _ Dictionary new.
	record2 at: 'firstname' put: 'Dagobert'.
	record2 at: 'lastname' put: 'Duck'.
	record2 at: 'username' put: 'scrooge'.
	
	self assert: record2 equals: reader nextRecord.
		
	record3 _ Dictionary new.
	record3 at: 'firstname' put: 'Donald'.
	record3 at: 'lastname' put: 'Duck'.
	record3 at: 'username' put: 'ducky1'.
		
	self assert: record3 equals: reader nextRecord.
	
	self assert: reader atEnd.! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 19:16:46'!
testReadingOneLine
	| reader |
	
	reader _ usedClass on:  (self newRecord: #('a' 'b' 'c' 'd')) readStream.
	self assert: #('a' 'b' 'c' 'd') equals: reader nextRecord.! !

!TableRecordReaderTest methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 19:21:44'!
testReadingSimpleLines
	| reader lines |
	
	lines _ {
		self newRecord: #('a' 'b' 'c' 'd').
		self newRecord: #('doo' 'boo' 'roo' 'loo').
		self newRecord: #('java' 'smalltalk' 'assembler' 'lisp').
	}.
	
	reader _ usedClass on:  (self newLines: lines) readStream.
	
	self assert: #('a' 'b' 'c' 'd') equals: reader nextRecord.
	self assert: #('doo' 'boo' 'roo' 'loo') equals: reader nextRecord.
	self assert: #('java' 'smalltalk' 'assembler' 'lisp') equals: reader nextRecord.
	
	self assert: #('a' 'b' 'c' 'd') equals: reader headers.
	
	self assert: reader atEnd.! !

!TableArrayRecordBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:30:25'!
value: fieldsProcessor
	"Builds a new record using the given fields processor"
	| newArray |
	newArray _ Array new: fieldsProcessor storedFieldsSize.
	
	^fieldsProcessor storeFieldsIn: newArray! !

!TableDictionaryRecordBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:52:25'!
convertField: newField
	^newField asString! !

!TableDictionaryRecordBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 13:03:28'!
detectNumbers
	fieldConverter detectNumbers ! !

!TableDictionaryRecordBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:55:02'!
initialize
	fieldConverter _ TableFieldConverter new! !

!TableDictionaryRecordBuilder methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:54:47'!
value: fieldsProcessor
	"Builds a new record using the given fields processor"
	^fieldsProcessor
		storeWithFieldNamesIn: Dictionary new
		using: fieldConverter ! !

!TableFieldConverter methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:56:09'!
detectNumbers
	"Returns numbers, if they are found in the input"
	
	detectNumbers _ true! !

!TableFieldConverter methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:56:27'!
ignoreNumbers
	"Returns numbers, if they are found in the input"
	
	detectNumbers _ false! !

!TableFieldConverter methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 13:03:11'!
initialize
	detectNumbers _ false! !

!TableFieldConverter methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 13:13:45'!
value: oldValue
	| newField  | 
	newField _ oldValue asString.
	
	(newField size > 0) ifFalse: [ ^newField ].
		
	detectNumbers
		ifTrue: [ | newNumber |
			newNumber _ [ newField asNumber ] on: Error do: [ nil ].
			newNumber isNil ifFalse: [ newField _ newNumber ] ].
	
	^newField! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:41:07'!
fieldEnd: newFieldEnd
	fieldEnd _ newFieldEnd! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:34:37'!
fieldNames
	"Returns the currently set fieldNames"
	^fieldNames! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:07:33'!
fieldNames: newFieldNames
	"Assigns the given field names to the processor"
	fieldNames _ newFieldNames ! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:40:57'!
fieldStart: newFieldStart
	"Sets a field start character"
	fieldStart _ newFieldStart! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 18:05:46'!
finishField
	"Finishes an open field and stores into the already stored fields"
	
	fieldIndex > 0 ifTrue: [ self storeField ].
	
	^false! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:48:54'!
initialize
	fields _ Array new: 255.
	field _ String new: 255.
	fieldNames _ nil.
	insideFieldState _ false.! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:49:57'!
isInsideField
	"Returns true if the fields processor is inside a field"
	^insideFieldState ! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:41:26'!
isOutsideField
	"Returns true if the fields processor is outside a field"
	^self isInsideField not! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:49:27'!
startNewField
	"Starts a field to be read in"
	fieldIndex _ 0.
	insideFieldState _ false.! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 18:01:00'!
startNewFields
	"Setups the state so new fields can be read in"
	fieldsIndex _ 0! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 18:27:09'!
storeField
	"Stores the currently read field into the list of already read fields"
	fieldsIndex _ fieldsIndex + 1.
	
	fieldIndex > 0
		ifTrue: [ fields at: fieldsIndex put: (field copyFrom: 1 to: fieldIndex) ]
		ifFalse: [ fields at: fieldsIndex put: '' ].! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:57:35'!
storeFieldChar: char
	"Stores the next field character into the field buffer"
	((fieldStart = char) and: [ self isOutsideField ])
		 ifTrue: [ insideFieldState _ true. ^self ].

	((fieldEnd = char) and: [ self isInsideField ] )
		 ifTrue: [ insideFieldState _ false. ^self ].
	
	fieldIndex _ fieldIndex + 1.
	field at: fieldIndex put: char.! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:36:40'!
storeFieldNames
	"Stores the current fields as a new set of fieldNames. But only if the current field names weren't yet set"
	fieldNames isNil
		ifTrue: [ fieldNames _ self storedFields ].! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:25:17'!
storeFieldsIn: aCollection 
	"Returns the currently read fields in the given collection"
	
	(1 to: fieldsIndex) do: [:index| aCollection at: index put: (fields at: index). ].
	
	^aCollection! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:25:05'!
storeFieldsIn: aCollection using: aMapping
	"Returns the currently read fields in the given collection using a mapping collection, which maps an index to something different"
	
	(1 to: fieldsIndex) do: [:index| 
		| keyName |
		keyName _ aMapping at: index ifAbsent: [ nil ].
		keyName isNil ifFalse: [		aCollection at: keyName put: (fields at: index)]].
	
	^aCollection! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:47:29'!
storeFieldsIn: aCollection using: aMapping converter: usedConverter
	"Returns the currently read fields in the given collection using a mapping collection, which maps an index to something different and a converter which is applied to each field"
	
	(1 to: fieldsIndex) do: [:index| 
		| keyName newValue |
		keyName _ aMapping at: index ifAbsent: [ nil ].
		newValue _ usedConverter value: (fields at: index).
		
		keyName isNil ifFalse: [		aCollection at: keyName put: newValue]].
	
	^aCollection! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:46:39'!
storeFieldsIn: aCollection using: aMapping converters: converterCollection
	"Returns the currently read fields in the given collection using a mapping collection, which maps an index to something different and a collection of converters to apply for each field"
	| defaultConverter |
	
	defaultConverter _ [:value | value asString ].
	
	(1 to: fieldsIndex) do: [:index| 
		| keyName usedConverter newValue |
		keyName _ aMapping at: index ifAbsent: [ nil ].
		usedConverter _ converterCollection at: keyName ifAbsent: [ defaultConverter ].
		newValue _ usedConverter value: (fields at: index).
		
		keyName isNil ifFalse: [		aCollection at: keyName put: newValue]].
	
	^aCollection! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:38:21'!
storeWithFieldNamesIn: aCollection
	"Returns the currently read fields in the given collection using a mapping collection, which maps an index to something different"
	
	^self storeFieldsIn: aCollection using: fieldNames! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 4/6/2021 12:50:17'!
storeWithFieldNamesIn: aCollection using: aConverter
	"Returns the currently read fields in the given collection using a mapping collection, which maps an index to something different"
	
	^self storeFieldsIn: aCollection using: fieldNames converter: aConverter! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 18:06:02'!
storedFields
	"Returns the currently read fields"
	
	^fields copyFrom: 1 to: fieldsIndex ! !

!TableFieldsProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 19:40:46'!
storedFieldsSize
	"Returns the currently size of read fields"
	
	^fieldsIndex! !

!TableLineProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:48:33'!
initialize
	lineBuffer _ ByteArray new: 1024.
	lineNumber _ 0.
	
	self startNewLine.! !

!TableLineProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:56:30'!
lineContents
	"Returns the currently read line"
	lineIndex = 0 ifTrue: [^''].
	
	^String fromUtf8: (lineBuffer copyFrom: 1 to: lineIndex)! !

!TableLineProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 18:32:24'!
startNewLine
	"Sets the state of the reader so that it's ready to read a new line"
	lineIndex _ 0.
	lineNumber _ lineNumber + 1.! !

!TableLineProcessor methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:55:53'!
storeChar: char
	"Stores the given character into the line buffer"
	lineIndex _ lineIndex + 1.
	lineBuffer at: lineIndex put: char numericValue.! !

!TableStreamReader methodsFor: 'enumerating' stamp: 'jpb 4/6/2021 10:21:27'!
do: aBlock
	[ self atEnd ]
		whileFalse: [ aBlock value: self next ]! !

!TableStreamReader methodsFor: 'testing' stamp: 'jpb 9/19/2020 15:05:37'!
atEnd
	^readStream atEnd! !

!TableStreamReader methodsFor: 'initialization' stamp: 'jpb 9/19/2020 11:37:07'!
initializeWithStream: newStream
	self initialize.

	readStream _ newStream.! !

!TableStreamReader methodsFor: 'accessing' stamp: 'jpb 4/6/2021 10:25:57'!
upToEnd
	| resultRecords |
	
	resultRecords _ OrderedCollection new.
	self do: [:record | resultRecords add: record ].
	
	^resultRecords! !

!TableStreamReader class methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 09:17:00'!
on: readStream
	| instance |
	instance _ self basicNew.
	
	instance initializeWithStream: readStream.
	^instance! !

!TableLineReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/18/2020 16:11:56'!
initialize
	crChar _ Character cr.
	lineFeedChar _ Character lf.
	lineProcessor _ TableLineProcessor new.! !

!TableLineReader methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 18:33:58'!
lineNumber
	"Returns the last read line number"
	^lineProcessor lineNumber! !

!TableLineReader methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 10:36:05'!
next
	^self nextLine! !

!TableLineReader methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 18:34:51'!
nextLine
	lineProcessor startNewLine.

	[ readStream atEnd not ]
		whileTrue: [ |char |
			char _ readStream next.
			
			char = lineFeedChar ifTrue: [ ^lineProcessor lineContents ].
			char = crChar ifTrue: [
				readStream peek = lineFeedChar
					ifTrue: [ readStream next. ^lineProcessor lineContents ]
					ifFalse: [ ^lineProcessor lineContents]].	
		
			lineProcessor storeChar: char.
		 ].
	
	^lineProcessor lineContents! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:04:15'!
headers
	"Returns the headers of the record file, which is the first line fields"
	^fieldsProcessor fieldNames! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:32:26'!
initialize
	delimiter _ Character tab.
	fieldsProcessor _ TableFieldsProcessor new.
	recordBuilder _ TableArrayRecordBuilder new.! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/18/2020 16:10:38'!
initializeWithStream: newStream
	self initialize.

	readStream _ TableLineReader on: newStream.! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 9/19/2020 11:49:58'!
next
	^self nextRecord! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 21:35:58'!
nextRecord
	"Reads the next raw tab separated record from the stream"
	self readLineFields.
	fieldsProcessor storeFieldNames.

	^recordBuilder value: fieldsProcessor! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:30:37'!
readLineFields
	"Reads the next raw tab separated record from the stream"
	| line |
	
	line _ readStream nextLine readStream.
	fieldsProcessor startNewField.
	fieldsProcessor startNewFields.
	
	[ line atEnd not ]
		whileTrue: [ 
			self storeInFieldUsing: line. 	
	].
	fieldsProcessor finishField.! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/19/2020 20:37:17'!
recordBuilder: newBuilder
	recordBuilder _ newBuilder! !

!TableRecordReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/20/2020 20:46:32'!
storeInFieldUsing: lineStream
	| char |
	char _ lineStream next.
	
	(char = delimiter) & fieldsProcessor isOutsideField
		ifTrue: [ fieldsProcessor storeField. fieldsProcessor startNewField. ^self ].
		
	fieldsProcessor storeFieldChar: char! !

!CsvReader methodsFor: 'as yet unclassified' stamp: 'jpb 10/17/2020 21:18:40'!
initialize
	super initialize.

	delimiter _ $,.
	fieldsProcessor fieldStart: $".
	fieldsProcessor fieldEnd: $"! !
