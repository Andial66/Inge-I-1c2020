!classDefinition: #BookCatalogTest category: #TusLibros!
TestCase subclass: #BookCatalogTest
	instanceVariableNames: 'aValidIsbn anInvalidIsbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookCatalogTest methodsFor: 'test' stamp: 'SC 7/5/2020 19:04:16'!
test01CatalogIsEmptyWhenCreated

	| bookCatalog |
	
	bookCatalog := BookCatalog new.
	
	self assert: (bookCatalog isEmpty) .! !

!BookCatalogTest methodsFor: 'test' stamp: 'SC 7/5/2020 19:36:48'!
test02CanAddIsbnToCatalog

	| bookCatalog |

	bookCatalog := BookCatalog new..
	
	bookCatalog addIsbn: aValidIsbn .
	
	self assert: (bookCatalog hasIsbn: aValidIsbn) .
	self deny: (bookCatalog isEmpty) .! !

!BookCatalogTest methodsFor: 'test' stamp: 'SC 7/5/2020 19:37:00'!
test03CantAddInvalidIsbnToCatalog

	| bookCatalog |

	bookCatalog := BookCatalog new.
	
	self should: [bookCatalog addIsbn: anInvalidIsbn . ]
		 raise: Error
		 withMessageText: BookCatalog invalidAddError .! !


!BookCatalogTest methodsFor: 'setUp' stamp: 'SC 7/5/2020 19:40:05'!
setUp

	aValidIsbn := 8420681865 .
	anInvalidIsbn := '1231' . ! !


!classDefinition: #ShoppingCartTest category: #TusLibros!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'catalog anIsbnInCatalog validClientId validPassword anIsbnNotInCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCartTest methodsFor: 'testAdd' stamp: 'SC 7/5/2020 19:27:40'!
test04CanAddBookToCartIfIsbnBelongsToCatalog

	| shoppingCart |
	
	shoppingCart := ShoppingCart createCartWithClientId: validClientId andPassword: validPassword fromCatalog: catalog.
	
	shoppingCart add: 1 booksOfIsbn: anIsbnInCatalog .
	
	self assert: ((shoppingCart numberOfBooksFromIsbn: anIsbnInCatalog ) = 1) .
	self assert: (shoppingCart totalNumberOfBooks = 1) .
	self deny: (shoppingCart isEmpty).
	
	 
	
	! !

!ShoppingCartTest methodsFor: 'testAdd' stamp: 'SC 7/5/2020 19:18:54'!
test05CantAddBookToCartWithNonPositiveQuantity

	| shoppingCart |
	
	shoppingCart := ShoppingCart createCartWithClientId: validClientId andPassword: validPassword fromCatalog: catalog.
	
	self should: [shoppingCart add: -2 booksOfIsbn: anIsbnInCatalog ]
		 raise: Error
		 withMessageText: ShoppingCart invalidQuantityError .
	
	
	 
	
	! !

!ShoppingCartTest methodsFor: 'testAdd' stamp: 'SC 7/5/2020 19:19:06'!
test06CantAddBookToCartWithNonIntegerQuantity

	| shoppingCart |
	
	shoppingCart := ShoppingCart createCartWithClientId: validClientId andPassword: validPassword fromCatalog: catalog.
	
	self should: [shoppingCart add: 3.5 booksOfIsbn: anIsbnInCatalog ]
		 raise: Error
		 withMessageText: ShoppingCart invalidQuantityError .
	
	
	 
	
	! !

!ShoppingCartTest methodsFor: 'testAdd' stamp: 'SC 7/5/2020 19:27:48'!
test07CantAddBookToCartIfIsbnDoesntBelongToCatalog

	| shoppingCart |
	
	shoppingCart := ShoppingCart createCartWithClientId: validClientId andPassword: validPassword fromCatalog: catalog.
	
	self should: [ shoppingCart add: 1 booksOfIsbn: anIsbnNotInCatalog ]
		 raise: Error 
		 withMessageText: BookCatalog isbnNotInCatalog.
	
	 
	
	! !


!ShoppingCartTest methodsFor: 'setUp' stamp: 'SC 7/5/2020 19:39:16'!
setUp

	catalog := BookCatalog new .
	
	anIsbnInCatalog := 8420681865 .
	anIsbnNotInCatalog := 9780201537710 . 
	catalog addIsbn: anIsbnInCatalog .
	
	validClientId := 1.
	validPassword := 1.
	
	 
	
	! !


!ShoppingCartTest methodsFor: 'testCreate' stamp: 'SC 7/5/2020 19:18:10'!
test01CartIsEmptyWhenCreated

	| shoppingCart |
	
	shoppingCart := ShoppingCart createCartWithClientId: validClientId andPassword: validPassword fromCatalog: catalog.
	
	self assert: shoppingCart isEmpty .! !

!ShoppingCartTest methodsFor: 'testCreate' stamp: 'SC 7/5/2020 19:18:16'!
test02CantCreateCartWithInvalidUsername

	| shoppingCart |
	
	self should: [shoppingCart := ShoppingCart createCartWithClientId: nil andPassword: validPassword fromCatalog: catalog.]
		 raise: Error
		 withMessageText: ShoppingCart invalidCredentialsError .! !

!ShoppingCartTest methodsFor: 'testCreate' stamp: 'SC 7/5/2020 19:18:23'!
test03CantCreateCartWithInvalidPassword

	| shoppingCart |
	
	self should: [shoppingCart := ShoppingCart createCartWithClientId: validClientId andPassword: nil fromCatalog: catalog.]
		 raise: Error
		 withMessageText: ShoppingCart invalidCredentialsError .! !


!classDefinition: #BookCatalog category: #TusLibros!
Object subclass: #BookCatalog
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookCatalog methodsFor: 'access' stamp: 'SC 7/5/2020 19:07:50'!
hasIsbn: anIsbn

	^catalog includes: anIsbn .! !

!BookCatalog methodsFor: 'access' stamp: 'SC 7/5/2020 19:06:57'!
isEmpty

	^catalog isEmpty .! !


!BookCatalog methodsFor: 'operations' stamp: 'SC 7/5/2020 19:09:37'!
addIsbn: anIsbn

	self validateIsbn: anIsbn .

	catalog add: anIsbn .! !


!BookCatalog methodsFor: 'validate' stamp: 'SC 7/5/2020 19:10:16'!
validateIsbn: anIsbn

	(anIsbn isInteger)
		ifFalse: [self signalInvalidAdd] .! !


!BookCatalog methodsFor: 'signal' stamp: 'SC 7/5/2020 19:10:29'!
signalInvalidAdd

	self error: self class invalidAddError .! !


!BookCatalog methodsFor: 'initialize' stamp: 'SC 7/5/2020 19:12:13'!
initialize

	catalog := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookCatalog class' category: #TusLibros!
BookCatalog class
	instanceVariableNames: ''!

!BookCatalog class methodsFor: 'exceptions' stamp: 'SC 7/5/2020 19:11:22'!
invalidAddError

	^'Invalid Isbn'! !

!BookCatalog class methodsFor: 'exceptions' stamp: 'SC 7/5/2020 19:23:18'!
isbnNotInCatalog

	^'Isbn not in Catalog'! !


!classDefinition: #ShoppingCart category: #TusLibros!
Object subclass: #ShoppingCart
	instanceVariableNames: 'elements catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'initialize' stamp: 'SC 7/5/2020 19:17:34'!
initializeWithClientId: aClientId andPassword: aPassword fromCatalog: aCatalog

	self validateClientId: aClientId withPassword: aPassword .
	
	elements := Dictionary new.
	catalog := aCatalog.

	^self .! !


!ShoppingCart methodsFor: 'validate' stamp: 'SC 7/5/2020 18:32:43'!
validateClientId: aClientId withPassword: aPassword .

	(aClientId = nil | (aPassword = nil)) 
		ifTrue: [self signalInvalidCredentials]! !

!ShoppingCart methodsFor: 'validate' stamp: 'SC 7/5/2020 19:21:46'!
validateIsbn: anIsbn .
	
	(catalog hasIsbn: anIsbn)
		ifFalse: [self signalIsbnNotInCatalog]
	
	! !

!ShoppingCart methodsFor: 'validate' stamp: 'SC 7/5/2020 18:57:34'!
validateQuantity: aQuantity .
	
	(aQuantity strictlyPositive & aQuantity isInteger)
		ifFalse: [self signalInvalidQuantity]
	! !


!ShoppingCart methodsFor: 'access' stamp: 'SC 7/5/2020 19:28:21'!
isEmpty

	^elements isEmpty .! !

!ShoppingCart methodsFor: 'access' stamp: 'SC 7/5/2020 18:47:15'!
numberOfBooksFromIsbn: anIsbn

	^elements at: anIsbn ifAbsent: [0] .
	
	! !

!ShoppingCart methodsFor: 'access' stamp: 'SC 7/5/2020 18:51:51'!
totalNumberOfBooks

	^elements sum: [ :aQuantity | aQuantity] ifEmpty: [0] .
		 ! !


!ShoppingCart methodsFor: 'signal' stamp: 'SC 7/5/2020 18:27:49'!
signalInvalidCredentials
	
	self error: self class invalidCredentialsError .! !

!ShoppingCart methodsFor: 'signal' stamp: 'SC 7/5/2020 18:57:46'!
signalInvalidQuantity

	self error: self class invalidQuantityError .
	! !

!ShoppingCart methodsFor: 'signal' stamp: 'SC 7/5/2020 19:24:15'!
signalIsbnNotInCatalog

	self error: BookCatalog isbnNotInCatalog
	
	! !


!ShoppingCart methodsFor: 'operations' stamp: 'SC 7/5/2020 18:55:35'!
add: aQuantity booksOfIsbn: anIsbn

	| currentQuantity |

	self validateIsbn: anIsbn .
	self validateQuantity: aQuantity .
	
	currentQuantity := elements at: anIsbn ifAbsent: [0] .
	
	elements at: anIsbn put: currentQuantity + aQuantity
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #TusLibros!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'exceptions' stamp: 'SC 7/5/2020 18:28:17'!
invalidCredentialsError

	^'Invalid credentials' ! !

!ShoppingCart class methodsFor: 'exceptions' stamp: 'SC 7/5/2020 18:55:10'!
invalidQuantityError

	^'Quantity of books must be positive integer' ! !


!ShoppingCart class methodsFor: 'initialize' stamp: 'SC 7/5/2020 19:17:07'!
createCartWithClientId: aClientId andPassword: aPassword fromCatalog: catalog

	^ShoppingCart new initializeWithClientId: aClientId andPassword: aPassword fromCatalog: catalog.! !
